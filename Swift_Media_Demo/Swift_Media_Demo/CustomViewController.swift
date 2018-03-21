//
//  CustomViewController.swift
//  Swift_Media_Demo
//
//  Created by mac on 17/8/16.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import AVFoundation

class CustomViewController: UIViewController, PlayerTimeDelegate {

    @IBOutlet weak var player: MoviePlayer!
    @IBOutlet weak var playBar: CustomPlayView!
//    @IBOutlet weak var cPlayView: CustomPlayView!
    
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var progress: UISlider!
    @IBOutlet weak var decreacePlay: UIButton!
    @IBOutlet weak var quickPlay: UIButton!
    
    
    var isShowAnim = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configView()
        
    }
    
    func configView(){
        //给自定义的View添加点击手势
        let tap = UITapGestureRecognizer(target: self, action: "clickView:")
        self.view.addGestureRecognizer(tap)
        
        //添加视频并播放
        //获取本地视频路径
        let filePath = NSBundle.mainBundle().pathForResource("12.使用AVPlayer定制播放视频控件_1", ofType: "mp4")
        self.player.initPlayer(filePath!)
        
        self.player.delegate = self
    }

    func clickView(sender: AnyObject) {
        print("点击手势生效")
        if isShowAnim {
            self.playBar.startAnim()
            self.player.play()
            isShowAnim = false
        }else{
            //执行绘制动画
            self.playBar.endAnim()
            isShowAnim = true
            self.player.pause()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime(currentTime: CGFloat, duration: CGFloat) {
        print("currentTime = \(currentTime) : duration = \(duration)")
        let current = timeFormatFromSecond(currentTime)
        let duration1 = timeFormatFromSecond(duration)
        self.currentTime.text = current
        self.duration.text = duration1
        
        self.progress.value = Float(currentTime)/Float(duration)
    }
    
    //格式化时间
    func timeFormatFromSecond(second: CGFloat) -> String {
        var tiemStr = ""
        //将秒转为时分秒
        var hour = 0
        var minute = 0
        var seconds = 0
        seconds = Int(second)%60
        hour = Int(second)/60/60
        minute = Int(second)/60 % 60
        tiemStr = "\(hour):\(minute):\(seconds)"
        return tiemStr
    }
    
    @IBAction func changeProgress(sender: AnyObject) {
        //获取到当前的值
        let slider = sender as! UISlider
        //默认0～1
        let value = slider.value
        print("value = \(value)")
        player.pause()
        let jumpToTime = Float(CMTimeGetSeconds((player.player.currentItem?.duration)!)) * value
        let cmTime = CMTime.init(seconds: Double(jumpToTime), preferredTimescale: 1)
        player.player.seekToTime(cmTime) { (complete) in
            self.player.play()
        }
    }
    
    @IBAction func decreacePlay(sender: AnyObject) {
        //
        self.player.decreacePlay()
    }
    
    @IBAction func quickPlay(sender: AnyObject) {
        //
        self.player.quickPlay()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
