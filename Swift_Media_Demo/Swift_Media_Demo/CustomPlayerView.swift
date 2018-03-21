//
//  CustomPlayerView.swift
//  Swift_Media_Demo
//
//  Created by mac on 17/8/16.
//  Copyright © 2017年 mac. All rights reserved.
//

//播放时间回调
protocol PlayerTimeDelegate{
    func updateTime(currentTime: CGFloat, duration: CGFloat)
}

import UIKit
//设计播放器时引用
import AVFoundation

class CustomPlayerView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
//自定义播放器
class MoviePlayer: UIView{
    //
    var delegate: PlayerTimeDelegate?
    let player = AVPlayer()
//    let playerItem: AVPlayerItem?
    var speedRate: Float = 1
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    //初始化播放器
    func initPlayer(file: String){
        //
        let fileUrl = NSURL(fileURLWithPath: file)
        let asset = AVURLAsset(URL: fileUrl)
        let playerItem = AVPlayerItem(asset: asset)
        //设置播放内容
        player.replaceCurrentItemWithPlayerItem(playerItem)
        //方便适配：
        let playerLayer = self.layer as! AVPlayerLayer
        playerLayer.player = player
        //设置自动适配屏幕宽高
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        
        //为了避免内存泄漏：
        weak var wPlayer: MoviePlayer? = self
        //监听播放时间并回传显示: 每隔多少时间获取一次 : KVO
        player.addPeriodicTimeObserverForInterval(CMTimeMake(1, 1), queue: nil) { (playTime) in
            let currentTime = CMTimeGetSeconds((wPlayer!.player.currentItem?.currentTime())!)
            let duration = CMTimeGetSeconds((wPlayer!.player.currentItem?.duration)!)
            self.delegate?.updateTime(CGFloat(currentTime), duration: CGFloat(duration))
        }
        
    }
    func play(){
        player.play()
    }
    
    func pause(){
        player.pause()
    }
    
    //快速播放
    func quickPlay(){
        if speedRate < 3 {
            speedRate = speedRate + 0.2
        }else{
            speedRate = 1
        }
        player.rate = player.rate + (player.rate * speedRate)
    }
    
    func decreacePlay(){
        if speedRate > -1 {
            speedRate = speedRate - 0.2
        }else{
            speedRate = 1
        }
        player.rate = player.rate - (player.rate * speedRate)
    }
    
//    如果你的UIView子类，想改变layer的类型，实现UIView子类的layerClass类方法并返回CALayer的子类
    override class func layerClass() -> AnyClass{
        return AVPlayerLayer.self
    }
    
}


//自定义播放按钮
class CustomPlayView: CustomPlayerView {
    //绘制路径：逐渐渲染绘制
    var shapLayer = CAShapeLayer()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        print("自定义布局必须重载")
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("自定义布局必须重载")
        initLayout(self, superWidth: frame.width, superHeight: frame.height)
    }
    
    func initLayout(super: UIView, superWidth: CGFloat, superHeight: CGFloat){
        shapLayer.strokeColor = UIColor.cyanColor().CGColor
        shapLayer.strokeStart = 0
        shapLayer.strokeEnd = 1
        shapLayer.lineWidth = 5
        shapLayer.fillColor = UIColor.greenColor().CGColor
        /* The cap style used when stroking the path. Options are `butt', `round'
         * and `square'. Defaults to `butt'. */
        shapLayer.lineCap = "round"
        /* The join style used when stroking the path. Options are `miter', `round'
         * and `bevel'. Defaults to `miter'. */
        shapLayer.lineJoin = "round"
        
        //设置绘制路径
        let path = UIBezierPath()
        //起始点坐标
        path.moveToPoint(CGPoint(x: 5, y: superHeight-5))
        //经过的点的坐标
        path.addLineToPoint(CGPoint(x: superWidth-5, y: superHeight/2-5))
        path.addLineToPoint(CGPoint(x: 5, y: 5))
        path.addLineToPoint(CGPoint(x: 5, y: superHeight*0.7-5))
        shapLayer.path = path.CGPath
        
        //设置动画效果
        shapLayer.animateBaseKey("strokeEnd", fromValue: NSNumber.init(float: 0), toValue: NSNumber.init(float: 1)) { (animateReturnIsGroup) -> Bool in
            animateReturnIsGroup.duration = 1
            //?
            return false
        }
        self.layer.addSublayer(shapLayer)
    }
    func startAnim(){
        //设置动画效果
        shapLayer.animateBaseKey("strokeStart", fromValue: NSNumber.init(float: 0), toValue: NSNumber.init(float: 1)) { (animateReturnIsGroup) -> Bool in
            animateReturnIsGroup.duration = 1
            return false
        }
    }
    func endAnim(){
        //设置动画效果
        shapLayer.animateBaseKey("strokeEnd", fromValue: NSNumber.init(float: 1), toValue: NSNumber.init(float: 0)) { (animateReturnIsGroup) -> Bool in
            animateReturnIsGroup.duration = 1
            return false
        }
    }
    override func drawRect(rect: CGRect) {
        //绘制图形
        print("绘制界面")
    }
}
