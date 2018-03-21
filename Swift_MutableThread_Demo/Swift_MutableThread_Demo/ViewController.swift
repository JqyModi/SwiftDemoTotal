//
//  ViewController.swift
//  Swift_MutableThread_Demo
//
//  Created by mac on 17/8/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    let row = 1
    let count = 6
    var cell: UICollectionViewCell?
    
    let path:NSString = "http://image.baidu.com/data/imgs?col=美女&tag=小清新&sort=0&pn=10&rn=10&p=channel&from=1"
    let path1 = "http://shiyan360.cn/index.php/api/examinPaperDetail?id=1"
    var path2 = "http://gank.io/api/data/福利/10/"
    
    var imgs = NSMutableArray()
    var results: NSArray?
    
    var sQueue: dispatch_queue_t?
    var cQueue: dispatch_queue_t?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.backgroundColor = UIColor.whiteColor()
//        self.collectionView.layer.borderColor = UIColor.redColor().CGColor
//        self.collectionView.layer.borderWidth = 1
        self.collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //定义collectionView的流式布局：通过它来控制Item的大小及排列方式等
        let flowLayout = UICollectionViewFlowLayout()
        //设置item排列方向
        flowLayout.scrollDirection = .Vertical
        //设置item大小
        flowLayout.itemSize = CGSize(width: 160, height: 150)
        //设置item间距
        //行间距：竖直间距
        flowLayout.minimumLineSpacing = 10
        //水平间距：item间距
        flowLayout.minimumInteritemSpacing = 5
        collectionView.collectionViewLayout = flowLayout
        
    }
    override func viewWillAppear(animated: Bool) {
//        //path中不能存在中文字符:先编码成UTF8
//        var utfUrl = ""
//        do{
//            utfUrl = self.path2.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!+arc4random_uniform(10).description
//            self.getDataWithImgs(utfUrl)
//        }catch{
//            print("数据访问失败")
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return row
//    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        //手动改变item的大小及位置：frame
//        let section = indexPath.section
        let row = indexPath.row
//
//        print("row = \(row)")
//        print("section = \(section)")
//        var width = (collectionView.frame.width - 5)/2
//        if row != 0 {
//            width = width + 5
//        }
//        cell!.frame = CGRectMake(CGFloat(row) * width, CGFloat(section*150), width, 150)
        cell?.backgroundColor = UIColor(red: 204/255, green: 1, blue: 66/255, alpha: 1)
        
        var img1 = UIImageView(frame: CGRectMake(0, 0, 160, 150))
        if self.imgs.count>0 {
            img1.image = self.imgs[row] as! UIImage
        }
        img1.contentMode = .ScaleToFill
        cell?.addSubview(img1)
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("index = \(indexPath.row)")
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        //控制每个Item的宽高
//        return CGSize(width: 160, height: 150)
//    }
    
    
    @IBAction func changeAction(sender: UISegmentedControl) {
        
        //多线程：三种方式实现多线程:网络访问资源并更新UI
        //1.GCD[Grand Central Dispatch]:串行(serial)/并发(concurrent)两种队列、主队列／全局队列／自定义队列
        //2.NSThread
        //3.NSOperationQueue
        //新建队列:串行/并发:用于GCD模式
        sQueue = dispatch_queue_create("serial_queue", DISPATCH_QUEUE_SERIAL)
        //并发
        cQueue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT)
        
        //path中不能存在中文字符:先编码成UTF8
        var utfUrl = ""
        do{
            utfUrl = self.path2.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!+arc4random_uniform(10).description
            self.getDataWithImgs(utfUrl)
        }catch{
            print("数据访问失败")
        }
        
        switch sender.selectedSegmentIndex {
        case 0: //GCD－异步－串行
            print("GCD－异步－串行")
            
//            dispatch_async(sQueue, {
//                //path中不能存在中文字符:先编码成UTF8
//                var utfUrl = ""
//                do{
//                    utfUrl = self.path2.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!+arc4random_uniform(10).description
//                    self.getDataWithURL(utfUrl)
//                }catch{
//                    
//                }
//                
//                
//            })
            
            //gcd-延时
            let delay = dispatch_time_t(5000)
            dispatch_after(delay, sQueue!, { 
                //path中不能存在中文字符:先编码成UTF8
                var utfUrl = ""
                do{
                    utfUrl = self.path2.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!+arc4random_uniform(10).description
                    self.getDataWithURL(utfUrl)
                }catch{
                    
                }
            })
            //gcd-重复
            
            
            break
        case 1: //GCD－异步－并发
            dispatch_async(cQueue!, {
                print("GCD－异步－并发")
                var utfUrl = ""
                do{
                    utfUrl = self.path2.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!+arc4random_uniform(20).description
                    self.getDataWithURL(utfUrl)
                }catch{
                    
                }
            })
            break
        case 2: //NSOperationQueue-异步
            let operateQueue = NSOperationQueue()
            operateQueue.addOperationWithBlock({ 
                print("NSOperationQueue-异步－串行")
                var utfUrl = ""
                do{
                    utfUrl = self.path2.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!+arc4random_uniform(10).description
                    self.getDataWithURL(utfUrl)
                }catch{
                    
                }
            })
            break
        case 3: //Thread-异步
            let thread = NSThread(target: self, selector: #selector(ViewController.startThread(_:)), object: nil)
            thread.start()
            break
        default:
            break
        }
    }
    
    func startThread(sender: NSThread) {
        print("Thread－异步－串行")
        var utfUrl = ""
        do{
            utfUrl = path2.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!+arc4random_uniform(10).description
            self.getDataWithURL(utfUrl)
        }catch{
            
        }
    }

    func getDataWithURL(url: String) {
        var datas: NSData?
        var index: Int = 0
        
        var img: UIImage?
        var reqURL = NSURL(string: url)
        var request = NSURLRequest(URL: reqURL!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response, data, error) in
            if error == nil {
                //解析数据
                //序列化二进制数据否则无法用计算机操作
                do{
                    let temp = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    let imgs = temp.valueForKey("results") as! NSArray
                    for i in 0 ..< imgs.count {
                        let imgUrl = imgs[i].valueForKey("url") as! String
                        reqURL = NSURL(string: imgUrl)
                        request = NSURLRequest(URL: reqURL!)
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (response, data, error) in
                            if error == nil {
                                //序列化数据
                                img = UIImage(data: data!)
                                datas = data
                                index = i
                                //在主线程更新UI
//                                dispatch_async(dispatch_get_main_queue(), { 
//                                    self.refreshUI(img!,i: i)
//                                })
                            }
                        })
                    }
                }catch{
                    print("序列化失败")
                }
                
                
            }
        }
        
    }
    
    func refreshUI(img: UIImage, i: Int) {
        var width = (collectionView.frame.width - 5)/2
        print("width = \(width)")
        for(var j=0;j<row*count;j++){
            if i == j {
                let indexPath = NSIndexPath(forItem: i, inSection: Int(i/2))
                let cell = self.collectionView.cellForItemAtIndexPath(indexPath)
                let img1 = UIImageView(frame: CGRectMake(0, 0, 160, 150))
                img1.image = img
                img1.contentMode = .ScaleToFill
                cell!.contentView.addSubview(img1)
            }
            
        }
        
    }
    
    func getDataWithImgs(url: String) {
        
        let group = dispatch_group_create()
        
        dispatch_group_async(group, self.sQueue!) {
            print("group1")
            let reqURL = NSURL(string: url)
            let request = NSURLRequest(URL: reqURL!)
            //同步网络请求
            do{
                let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
                let temp = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
                self.results = temp.valueForKey("results") as! NSArray
            }catch{
                
            }
            //异步网络请求
//            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response, data, error) in
//                if error == nil {
//                    //解析数据
//                    //序列化二进制数据否则无法用计算机操作
//                    do{
//                        let temp = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
//                        self.results = temp.valueForKey("results") as! NSArray
//                        
//                    }catch{
//                        print("序列化失败")
//                    }
//                    
//                    
//                }
//            }
        }
        
        dispatch_group_notify(group, self.sQueue!) {
            print("执行完毕1")
            dispatch_group_async(group, self.sQueue!) {
                print("group2")
                for i in 0..<self.count{
                    let imgUrl = self.results![i].valueForKey("url") as! String
                    let reqURL = NSURL(string: imgUrl)
                    let request = NSURLRequest(URL: reqURL!)
                    do{
                        let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
                        //序列化数据
                        let img = UIImage(data: data)
                        self.imgs.addObject(img!)
                    }catch{
                        
                    }
                }
            }
            dispatch_group_notify(group, dispatch_get_main_queue(), { 
                self.refreshCollectionView()
                print("刷新数据2")
            })
            
        }
        
        
    }
    
    func refreshCollectionView() {
        self.collectionView.reloadData()
    }
    
}

