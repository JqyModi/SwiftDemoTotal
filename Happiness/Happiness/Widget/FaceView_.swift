//
//  FaceView_.swift
//  Happiness
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
//:class表示：只能为class类型实现
protocol FaceViewDataSource: class {
    func smilinessForFaceView(sender: FaceView_) -> Double
}
@IBDesignable
class FaceView_: UIView {
    
    //定义数据源：可选因为可能为nil, 用weak修饰避免内存泄漏
    weak var dataSource: FaceViewDataSource?
    
    //定义微笑弧度：提取成数据源不可用作可直接设置属性
    /*
    @IBInspectable
    var smiliness: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }*/
    
    //定义脸部圆心
    var faceCenter: CGPoint {
        get {
            //将父类的center转为当前center
            return convert(center, from: superview)
        }
    }
    //定义脸部圆半径
    var faceRadius: CGFloat {
        get {
            //半径取宽和高中较小的
            return min(bounds.width, bounds.height) / 2 * scale
        }
    }
    //定义半径缩放比率
    @IBInspectable
    var scale: CGFloat = 0.90 {
        didSet {
            //改变时需要重新绘制
            setNeedsDisplay()
        }
    }
    @objc
    func scale(gesture: UIPinchGestureRecognizer){
        //判断手势是否处于改变状态
        if gesture.state == .changed {
            scale *= gesture.scale
            //重置scale保留当前缩放比率
            gesture.scale = 1
        }
    }
    
    @IBInspectable
    var lineWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var faceColor: UIColor = UIColor.blue {
        didSet {
            setNeedsDisplay()
        }
    }
    //定义常量
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    //定义枚举
    private enum Eye {
        case Left
        case Right
    }
    //绘制眼睛路径
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye {
        case .Left:
            eyeCenter.x -= eyeHorizontalSeparation / 2
        case .Right:
            eyeCenter.x += eyeHorizontalSeparation / 2
        default:
            break
        }
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
    //绘制嘴型弧度：微笑 -1~1之间
    private func bezierPathForSmile(fractionMaxOfSmile: Double) -> UIBezierPath {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        //微笑弧度在-1~1之间
        let smileHeight = CGFloat(max(min(fractionMaxOfSmile, 1), -1)) * mouthHeight
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        //定义弧上两点
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.move(to: start)
//        path.addQuadCurve(to: cp1, controlPoint: cp2)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        //设置路径
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        //设置颜色：set = setfill + setStroke
        faceColor.set()
        //设置画笔宽度
        facePath.lineWidth = lineWidth
        //开始绘制图形
        facePath.stroke()
        
        //绘制眼睛
        bezierPathForEye(whichEye: .Left).stroke()
        bezierPathForEye(whichEye: .Right).stroke()
        //绘制嘴巴
        //通过自身代理获取数据源：这里数据源可能为nil用可选链返回一个默认值
        let smiliness = dataSource?.smilinessForFaceView(sender: self) ?? 0.0
        bezierPathForSmile(fractionMaxOfSmile: smiliness).stroke()
    }

}
