//
//  AnimViewController.swift
//  swift_demo
//
//  Created by mac on 17/8/9.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
/*
 视图动画：系统集成在UIView中直接调用
 */
class AnimViewController: UIViewController {

    @IBOutlet weak var startAnim: UIButton!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var canMoveView: UIView!
    @IBOutlet weak var subView1: UIView!
    
    var orgFrame: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orgFrame = self.canMoveView.frame
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startAnim(sender: UIButton) {
        //给view添加动画:可改变view的frame、bounds、center、transform、alpha、backgroundColor、contentStretch
//        UIView.animateWithDuration(2, delay: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: {
//            self.canMoveView.frame.origin.x = 100
//            //动画嵌套：内部动画会集成外部动画的时间、部分option、及
//            UIView.animateWithDuration(5, delay: 0, options: .TransitionCurlDown, animations: {
//                self.canMoveView.frame.origin.y = 100
//                }, completion: { (isComplete) in
//                    print("inner exec finished")
//            })
//            }) { (complete) in
//                print("outside exec finished")
//                print("动画执行完成")
//        }
        
        //usingSpringWithDamping: 1 : 反弹效果, initialSpringVelocity: 1 ：弹簧效果，值越小反弹动力越大
//        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
//            self.canMoveView.frame.origin.x = 100
//            self.canMoveView.frame.origin.y = 100
//            
//            }) { (isComplete) in
//                print("动画执行完成")
//        }
//        self.beginAnim()
        
        //操作子视图动画及转场动画
//        self.startSubviewAnim()
        
        //核心动画
        self.coreAnimation()
    }

    @IBAction func reset(sender: UIButton) {
        self.canMoveView.frame = self.orgFrame!
        //移除所有动画效果
        self.canMoveView.layer.removeAllAnimations()
    }
    
    func beginAnim() {
        UIView.beginAnimations("animate", context: nil)
        UIView.setAnimationDuration(2)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationRepeatCount(2)
        
        self.canMoveView.frame.origin.x = 100
        self.canMoveView.frame.origin.y = 100
        
        //设置动画事件委托
        UIView.setAnimationDelegate(self)
        UIView.setAnimationWillStartSelector("animationDidStart:")
//        UIView.setAnimationDidStopSelector("animationDidStop:finished:")
        //提交动画
        UIView.commitAnimations()
    }
    
    func startSubviewAnim() {
        //转场动画
//        UIView.transitionFromView(self.canMoveView, toView: self.subView1, duration: 1, options: .TransitionCurlDown) { (isComplete) in
//            print("animate is finish!")
//        }
        //操作子视图动画
        UIView.transitionWithView(self.canMoveView, duration: 1, options: .Autoreverse, animations: {
            self.subView1.backgroundColor = UIColor.cyanColor()
            self.subView1.alpha = 0.5

            }) { (isComplete) in
                
        }
    }
    /*
     隐式动画：直接通过改变视图或者layer的属性来完成的动画效果：不能控制动画过程状态属性
     显示动画：类似Android中的属性动画
     帧动画:
     */
    func coreAnimation() {
        //layer:图层对象 ： 1.动画发生的地方 2.通过layer设置View的外观样式[backgroundColor、border、content、corner、shadow...]
        //CALayer:类似View使用：每一个View对应一个layer： 
        let layer = CALayer()
        layer.frame = CGRectMake(100, 100, 150, 150)
        layer.backgroundColor = UIColor.redColor().CGColor
        layer.borderColor = UIColor.cyanColor().CGColor
        layer.borderWidth = 3
        layer.shadowColor = UIColor.brownColor().CGColor
        layer.shadowOffset = CGSize(width: 10, height: 10)
        //图层阴影透明度
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 10
        self.view.layer.addSublayer(layer)
        
        //CABaseAnimation
        //旋转动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnim.fromValue = 0
        rotationAnim.toValue = 230
        rotationAnim.duration = 1
        rotationAnim.autoreverses = true
//        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.speed = 0.2
        /* Defines how the timed object behaves outside its active duration.
         * Local time may be clamped to either end of the active duration, or
         * the element may be removed from the presentation.The legal values
         * are `backwards', `forwards', `both' and `removed'. Defaults to
         * `removed'. */
        rotationAnim.fillMode = kCAFillModeForwards
//        layer.addAnimation(rotationAnim, forKey: "rotate")
        //平移动画
        let translateAnim = CABasicAnimation(keyPath: "position")
        translateAnim.fromValue = [100, 100]
        translateAnim.toValue = [180, 240]
        translateAnim.duration = 1
        translateAnim.autoreverses = true
        //        rotationAnim.repeatCount = MAXFLOAT
        translateAnim.speed = 0.2
        /* Defines how the timed object behaves outside its active duration.
         * Local time may be clamped to either end of the active duration, or
         * the element may be removed from the presentation.The legal values
         * are `backwards', `forwards', `both' and `removed'. Defaults to
         * `removed'. */
        translateAnim.fillMode = kCAFillModeForwards
//        layer.addAnimation(translateAnim, forKey: "translate")
        
        //CAKeyframeAnimation
        //帧动画
        let frameAnim = CAKeyframeAnimation(keyPath: "position")
        frameAnim.values = [[0,0],[0,self.view.frame.height],[self.view.frame.width,0],[self.view.frame.width,self.view.frame.height]]
        
        frameAnim.duration = 10
        frameAnim.autoreverses = true
        frameAnim.repeatCount = 1
        //设置每段位移时间
//        frameAnim.keyTimes = [2,3,1,4]
        layer.addAnimation(frameAnim, forKey: "frameAnim")
        //CATransition
        
    }
    
    //实现动画事件委托
    override func animationDidStart(anim: CAAnimation) {
        print("动画开始")
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("动画结束")
    }
    
}
