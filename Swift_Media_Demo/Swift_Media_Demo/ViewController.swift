//
//  ViewController.swift
//  Swift_Media_Demo
//
//  Created by mac on 17/8/14.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
//导入媒体库:音视频播放
import AVFoundation
import AVKit

class ViewController: UIViewController, AVPlayerViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITabBarDelegate {

    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var tabbar: UITabBar!
    
    let PATH = "http://shiyan360.cn/index.php/api/video_list?desc_type=2&category_id=0&gradeid=408&page=1"
    var items = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabbar.delegate = self
        //获取网络视频资源
        requestDataFromUrl(PATH)
        //获取本地视频资源:
        searchDataFromLocal()
        
        initVideoPlayer()
        
    }

    func searchDataFromLocal(){
        //获取沙盒路径:数组
        let pathArr = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        //查看path路径下是否有视频文件
        for item in pathArr {
            print("path = \(pathArr)")
            
        }
        
        //通过滑动UISlider控制播放
        //1.记录当前时间
        
        //2.记录结束时间
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initVideoPlayer(){
        
    }
    
    func requestDataFromUrl(path: String){
        let nsUrl = NSURL(string: path)
        //系统内部访问网络获取数据
        let data = NSData(contentsOfURL: nsUrl!)
        if data != nil {
            let dict: NSDictionary?
            do{
                dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                let data = dict?.valueForKey("data") as! NSArray
                self.items = data
            }catch{
                print("序列化失败")
            }
        }
        
    }
    
    func playAction(path: String) {
        let player = AVPlayerViewController()
        
        let url = NSURL(string: path)
//        let play = AVPlayer(URL: NSURL(string: "http://www.shiyan360.cn/Public/Uploads/Video/20170802/59818b6863781.mp4")!)
        let play = AVPlayer(URL: url!)
        //设置play属性
        
        player.player = play
        //是否显示播放控制工具按钮
        player.showsPlaybackControls = true
        //设置跳转到视频页时的翻页效果:FlipHorizontal[翻转]PartialCurl[上翻页]CoverVertical[向上弹出]CrossDissolve[淡入]
        player.modalTransitionStyle = .FlipHorizontal
        //??
        player.modalPresentationStyle = .PageSheet
//        @discussion	Options are AVLayerVideoGravityResizeAspect, AVLayerVideoGravityResizeAspectFill and AVLayerVideoGravityResize. AVLayerVideoGravityResizeAspect is default.
        //设置视频的缩放模式
//        player.videoGravity = AVLayerVideoGravityResizeAspectFill
        player.delegate = self
        player.allowsPictureInPicturePlayback = true
        //设置播放界面大小
//        player.view.frame = CGRectMake(8, (UIScreen.mainScreen().bounds.height - 220)/2, UIScreen.mainScreen().bounds.width - 16, 220)
        player.view.layer.borderColor = UIColor.greenColor().CGColor
        player.view.layer.borderWidth = 2
//        player.view.layer.frame = CGRectMake(50, (UIScreen.mainScreen().bounds.height - 232)/2, UIScreen.mainScreen().bounds.width-100, 232)
//        player.view.layer.backgroundColor = UIColor.greenColor().CGColor
//        player.view.layer.cornerRadius = 5
//        player.view.layer.shadowColor = UIColor.greenColor().CGColor
//        player.view.layer.shadowOffset = CGSize(width: UIScreen.mainScreen().bounds.width - 8, height: 228)
//        player.view.layer.shadowOpacity = 0.8
//        self.view.addSubview(player.view)
//        play.play()
        self.presentViewController(player, animated: true) {
            play.play()
        }
    }
    //每个分区Item数量
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    //分区个数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        collectionView.clipsToBounds = true
        
        let row = indexPath.row
        print("row = \(row)")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        //设置cell扁平化
        
        cell.layer.masksToBounds = false
        
        //@mg:masksToBounds必须为NO否者阴影没有效果
        
        //    cell.layer.masksToBounds = NO;
        
        cell.layer.contentsScale = UIScreen.mainScreen().scale;
        cell.layer.shadowOpacity = 0.75;
        cell.layer.shadowRadius = 4.0;
        cell.layer.shadowOffset = CGSizeMake(5,5);
        cell.layer.shadowPath = CGPathCreateWithRect(cell.bounds, nil)
//        cell.layer.shadowColor = UIColor(red: 99/255*0.8, green: 0.8, blue: 99/255*0.8, alpha: 0.6).CGColor
        cell.layer.shadowColor = UIColor.grayColor().CGColor
        //设置缓存
        cell.layer.shouldRasterize = true;
        //设置抗锯齿边缘
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale;
        
        let imgView = cell.viewWithTag(101) as! UIImageView
        let item = self.items[row] as! NSDictionary
        let thumburl = item.valueForKey("img_url_s") as! String
        let imgData = NSData(contentsOfURL: NSURL(string:thumburl)!)
        let img = UIImage(data: imgData!)
        imgView.image = img
        let label = cell.viewWithTag(102) as! UILabel
        label.backgroundColor = UIColor(red: 99/255, green: 1, blue: 99/255, alpha: 0.6)
        let desc = item.valueForKey("name") as! String
        print("name = \(desc)")
        label.textColor = UIColor.redColor()
        label.adjustsFontSizeToFitWidth = true
        label.text = desc
//        cell.insertSubview(label, aboveSubview: imgView)
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        print("row = \(row)")
        //获取视频链接
        let item = self.items[row] as! NSDictionary
        let videoUrl = item.valueForKey("video_url") as! String
//        self.playAction(videoUrl)
        
        let cVC = CustomViewController()
        self.showViewController(cVC, sender: nil)
//        self.presentViewController(cVC, animated: true, completion: {
//            print("finish")
//            
//        })
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var width:CGFloat = 0
        var height:CGFloat = 0
        width = (collectionView.frame.width-10)/2
        height = width*5/8
        let size = CGSize(width: width, height: height)
        return size
    }
    
    //
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        let tag = item.tag
        switch tag {
        case 101:
            print("101")
            
        case 102:
            print("102")
            let cVC = CustomViewController()
            
            self.presentViewController(cVC, animated: true, completion: { 
                print("finish")
                
            })
        default:
            break;
        }
    }
    
}

