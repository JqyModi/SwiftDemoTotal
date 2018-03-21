//
//  ViewController.swift
//  Swift_MutThread_Demo
//
//  Created by mac on 17/8/14.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {

    var imgs: NSMutableArray?
    
    var imgView: UIImageView?
    var width: CGFloat?
    var height: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //通过布局中拖拽方式给当前的collectionView设置了代理：不用手动获取实例并设置代理
        self.imgs = NSMutableArray()
        //访问访问获取图片列表
        let path = "http://gank.io/api/data/福利/10/1"
        
        getImagesByURL(path)
        
    }

    func getImagesByURL(path: String){
        //path中不能含有中文需要重新编码
        let utfPath = path.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let url = NSURL(string: utfPath!)
        let request = NSURLRequest(URL: url!)
        //通过NSOperation方式进行异步操作:操作2依赖于操作1
        let imgUrls = NSMutableArray()
        let operation1 = NSBlockOperation {
            //需要操作
            let data = NSData(contentsOfURL: url!)
            do{
                if data != nil {
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    let results = dict["results"] as! NSArray
                    for item in results{
                        let itemObj = item as! NSObject
                        imgUrls.addObject(itemObj.valueForKey("url")!)
                        
                    }
                    
                }
            }catch{
                print("操作失败")
            }
            
        }
        let operation2 = NSBlockOperation {
            //需要操作
            if imgUrls.count > 0 {
                for item in imgUrls {
                    let data = NSData(contentsOfURL: NSURL(string: item as! String)!)
                    if data != nil {
                        let img = UIImage(data: data!)
                        self.imgs?.addObject(img!)
                    }
                }
            }
        }
       
        //设置依赖关系
        operation2.addDependency(operation1)
        //管理操作并开始执行
        let operQueue = NSOperationQueue()
        operQueue.addOperations([operation1,operation2], waitUntilFinished: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        //设置图片展示
        //获取storeboard中的图片控件
        imgView = cell.viewWithTag(1) as! UIImageView
        let img = self.imgs![indexPath.row]
        print("img1 = \(img.description)")
        if self.imgs?.count > 0 {
            imgView!.image = img as! UIImage
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        width = (collectionView.frame.width-10)/2
        height = width!*5/8
        return CGSize(width: width!, height: height!)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("index = \(indexPath.row)")
        //点击随机更换一张图片
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        //获取storeboard中的图片控件
        self.imgView = cell!.viewWithTag(1) as! UIImageView
        print("random() = \(random())")
        print("arc4random() = \(arc4random())")
        print("arc4random_uniform(10) = \(arc4random_uniform(10))")
        
        let r = Int(arc4random_uniform(UInt32((self.imgs?.count)!)))
        let img = self.imgs![r]
        print("img2 = \(img.description)")
        if self.imgs?.count > 0 {
            dispatch_async(dispatch_get_main_queue(), {
                //添加动画效果
                UIView.animateWithDuration(1, animations: { 
                    self.imgView?.transform = CGAffineTransformMakeScale(0.5, 0.5)
                    self.imgView!.image = img as! UIImage
                })
                self.imgView?.transform = CGAffineTransformMakeScale(1, 1)
            })
        }
        //将数据源中数据交换位置
//        self.imgs?.exchangeObjectAtIndex(indexPath.row, withObjectAtIndex: r)
//        collectionView.reloadData()
    }
}

