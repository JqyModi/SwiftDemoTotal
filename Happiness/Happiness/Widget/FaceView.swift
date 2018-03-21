//
//  FaceView.swift
//  Happiness
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
@IBDesignable
class FaceView: UIView {
    @IBInspectable
    var scale: CGFloat = 0.9 {
        didSet{
            setNeedsLayout()
        }
    }
    override func draw(_ rect: CGRect) {
        drawFace()
        drawEye()
        drawMouth()
        drawNose()
        drawCap()
        //
        drawText()
        //
        drawImage()
    }

    func drawFace(){
        let arcCenter = CGPoint(x: frame.width/2, y: frame.height/2)
        let radius = frame.width/2 * scale
        let startAngle = 0
        let endAngle = 2 * Double.pi
        
        let innerColor = UIColor.gray
        let frameColor = UIColor.red
        //设置路径
        let bPath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        //描边
        innerColor.setFill()
        frameColor.setStroke()
        //填充
        bPath.fill()
        bPath.stroke()
    }
    
    func drawEye(){
        let arcCenter1 = CGPoint(x: frame.width/2 - frame.width/2 * scale/2, y: frame.height/2 - frame.width/2 * scale/2)
        let arcCenter2 = CGPoint(x: frame.width/2 + frame.width/2 * scale/2, y: frame.height/2 - frame.width/2 * scale/2)
        let radius = 20 * scale
        let startAngle = 0
        let endAngle = 2 * Double.pi
        
        let innerColor = UIColor.black
        let frameColor = UIColor.gray
        //设置路径
        var bPath = UIBezierPath(arcCenter: arcCenter1, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        //描边
        innerColor.setFill()
        frameColor.setStroke()
        //填充
        bPath.fill()
        bPath.stroke()
        
        //设置路径
        bPath = UIBezierPath(arcCenter: arcCenter2, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        //描边
        innerColor.setFill()
        frameColor.setStroke()
        //填充
        bPath.fill()
        bPath.stroke()
    }
    func drawMouth(){
        let arcCenter = CGPoint(x: frame.width/2, y: frame.height/2)
        let radius = frame.width/2 * scale/2
        let startAngle = 1.5 * Double.pi - Double.pi * 1/5
        let endAngle = 1.5 * Double.pi + Double.pi * 1/5
        
        let innerColor = UIColor.green
        let frameColor = UIColor.green
        //设置路径
        let bPath = UIBezierPath()
        bPath.addArc(withCenter: arcCenter, radius: radius, startAngle: CGFloat(-startAngle), endAngle: CGFloat(-endAngle), clockwise: false)
        
        //描边
//        innerColor.setFill()
        frameColor.setStroke()
        //填充
//        bPath.fill()
        bPath.stroke()
    }
    func drawNose(){
        let arcCenter1 = CGPoint(x: frame.width/2, y: frame.height/2)
        let radius = 20 * scale
        let startAngle = 0
        let endAngle = 2 * Double.pi
        
        let innerColor = UIColor.yellow
        let frameColor = UIColor.red
        //设置路径
        var bPath = UIBezierPath(arcCenter: arcCenter1, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        //描边
        innerColor.setFill()
        frameColor.setStroke()
        //填充
        bPath.fill()
        bPath.stroke()
    }
    func drawCap(){
        let arcCenter = CGPoint(x: frame.width/2, y: frame.height/2)
        let radius = frame.width/2 * scale
        let startAngle = 1.5 * Double.pi - Double.pi * 1/5
        let endAngle = 1.5 * Double.pi + Double.pi * 1/5
        
        let innerColor = UIColor.green
        let frameColor = UIColor.green
        //设置路径
        let bPath = UIBezierPath()
        bPath.addArc(withCenter: arcCenter, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        
        //描边
        innerColor.setFill()
        frameColor.setStroke()
        //填充
        bPath.fill()
        bPath.stroke()
    }
    func drawText(){
        let text = "笑脸"
        let leftTopPoint = CGPoint(x: frame.width/2 - 15, y: frame.height/2 - (frame.width/2 * scale)-30)
        //单一绘制文字
//        let attrString = NSAttributedString(string: text)
        //可以设置绘制文字属性
        let attrString = NSMutableAttributedString(string: text)
        let attrs = [NSAttributedStringKey.strokeColor : UIColor.red
            ,NSAttributedStringKey.strokeWidth : 1] as [NSAttributedStringKey : Any]
        attrString.setAttributes(attrs, range: NSRange(location: 0, length: text.characters.count))
        attrString.draw(at: leftTopPoint)
    }
    func drawImage(){
        let img = UIImage(named: "ms")
//        let leftTopPoint = CGPoint(x: (frame.width - 50)/2, y: frame.height/2 + (frame.width/2 * scale) + 30)
        let rect = CGRect(x: (frame.width - 150)/2, y: frame.height/2 + (frame.width/2 * scale) + 30, width: 50, height: 80)
//        img?.draw(at: leftTopPoint)
        img?.draw(in: rect)
    }
    
    private enum EyeType {
        case Left
        case Right
    }
    
    private func createPathForEye(type: EyeType) -> UIBezierPath {
        var bPath = UIBezierPath()
        var arcCenter = CGPoint()
        let radius = 20 * scale
        let startAngle = 0
        let endAngle = 2 * Double.pi
        
        let innerColor = UIColor.black
        let frameColor = UIColor.gray
        //设置路径
        switch type {
        case .Left:
            arcCenter = CGPoint(x: frame.width/2 - frame.width/2 * scale/2, y: frame.height/2 - frame.width/2 * scale/2)
            bPath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        case .Right:
            arcCenter = CGPoint(x: frame.width/2 + frame.width/2 * scale/2, y: frame.height/2 - frame.width/2 * scale/2)
            bPath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        default:
            break
        }
        //描边
        innerColor.setFill()
        frameColor.setStroke()
        //填充
//        bPath.fill()
//        bPath.stroke()
        return bPath
    }
}
