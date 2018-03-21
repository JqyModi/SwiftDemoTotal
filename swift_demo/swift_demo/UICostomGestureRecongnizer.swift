//
//  UICostomGestureRecongnizer.swift
//  swift_demo
//
//  Created by mac on 17/8/9.
//  Copyright © 2017年 mac. All rights reserved.
//
/*
 自定义手势识别器
 1.继承UIGestureRecognizer
 2.导入UIKit下的UIGestureRecognizerSubclass:为了引入touch的几个方法：
 3.手势判断：顺序、轨迹、加速度、起始点坐标
 */


import UIKit
//2.
import UIKit.UIGestureRecognizerSubclass
//1.
class UICostomGestureRecongnizer: UIGestureRecognizer {
    
    var startFrame: CGRect?
    var endFrame: CGRect?
    
    var start: Bool = false
    var middle:Bool = false
    var end: Bool = false
    
    //
    var width: CGFloat?
    var height: CGFloat?
    
    override init(target: AnyObject?, action: Selector) {
        super.init(target: target, action: action)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        print("touchesBegan")
        width = self.view?.frame.size.width
        height = self.view?.frame.size.height
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        print("touchesMoved")
        
        let event = event.touchesForView(self.view!)?.first
        let eventX = event?.locationInView(self.view).x
        let eventY = event?.locationInView(self.view).y
        
        print("x = \(eventX) : y = \(eventY)")
        if eventX < 10 && eventY < 10 {
            start = true
        }
        if (eventX > self.width!/2-5 && eventX! < width!/2+5) && (eventY > height!/2-5 && eventY! < self.height!/2+5) {
            middle = true
        }
        if (eventX! > width!-10 && eventY! > height!-10) {
            end = true
        }
        if start && middle && end {
            print("手势识别成功")
            
        }else{
            print("手势识别失败")
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        print("touchesEnded")
        self.reset()
        
    }
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        print("touchesCancelled")
    }
}
