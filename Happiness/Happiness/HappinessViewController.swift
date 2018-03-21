//
//  ViewController.swift
//  Happiness
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
//Controller工作：为View解释Model，为Model解析View
class HappinessViewController: UIViewController, FaceViewDataSource {
    //设置Model
    var happiness: Int = 90 { //0: very sad 100: ecstatic
        didSet {
            //happiness介于0~100之间
            happiness = min(max(happiness, 0), 100)
            updateUI()
        }
    }
    
    //设置View
    @IBOutlet weak var faceView: FaceView_! {
        didSet {
            //利用代理模式连接View与Controller：
            faceView.dataSource = self
            //通过代码添加View上缩放手势:target由faceView本身处理
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(faceView.scale(gesture:))))
        }
    }
    
    private struct Contants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    //通过视图给FaceView_添加滑动手势：target是HappinessViewController
    @IBAction func changeHappiness(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
//        case .ended: fallthrough
        case .changed:
            let translation = sender.translation(in: faceView)
            let happinessChange = -Int(translation.y / Contants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(.zero, in: faceView)
            }
//        case .began:
//        case .failed:
//        case .cancelled:
//        case .possible:
        default:
            break
        }
    }
    
    //实现代理方法提供数据
    func smilinessForFaceView(sender: FaceView_) -> Double {
        //将数据转化为FaceView_中数据源所需要的数据(-1~1)并返回
        return Double(happiness - 50)/50
    }
    
    func updateUI(){
        //重绘视图
        faceView.setNeedsDisplay()
    }
}
