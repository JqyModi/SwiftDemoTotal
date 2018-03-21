//
//  note1.swift
//  swift_demo
//
//  Created by mac on 17/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

/*
 //程序 = 数据结构（静态） ＋ 算法（动态）
 
 //一门语言：  静态：变量，类
 动态：
 
 //IOS8:
 //层次结构分析
 
 IOS操作系统的层次结构
 
 
 　　1、Core OS 核心层：包含Accelerate Framework、External Accessory Framework、Security Framework、System等几个框架，基本都是基于c语言的接口
 　　2、Core Services核心服务层：包含Address Book Framework、CFNetwork Framework、Core Data Framework、Core Foundation Framework、Core Location Framework、Core Media Framework、Core Telephony Framework、Event Kit Framework、Foundation Framework、Mobile Core Services Framework、Quick Look Framework、Store Kit Framework、System Configuration Framework、Block Objects、Grand Central Dispatch  、In App Purchase、Location Services、SQLite、XML Support等一些框架，也基本都是基于c语言的接口。
 　　3、Mediah媒体层：包含Core Graphics、Core Animation、OpenGL ES、Core Text、Image I/O、Assets Library Framework、Media Player Framework、AV Foundation、OpenAL、Core Audio Frameworks、Core Media等等
 　　4、 Cocoa Touch 触摸层：包括Address Book UI Framework、Event Kit UI Framework、Game Kit Framework、iAd Framework、Map Kit Framework、Message UI Framework、UIKit Framework等等，这一层基本都是基于 Objective-c的接口
 
 //委托模式：APP启动过程采用的模式
 
 sense间跳转方式：
 1.modal :
 2.push:必须带导航栏跳转navigation，否则会报错，不压栈
 3.show：iOS8中推出show方式跳转场景代替push
 
 //自动布局：
 //1.Adopting:以前方式xcode4
 //2.AutoLayout xcode5 : 通过添加约束条件来布局目标控件
 //3.Size Classes xcode6 : 通过控制w/h来控制试图在不同屏幕尺寸下的布局方式及控件类型数量等差异
 
 //IOS应用程序生命周期
 运行－获取焦点becomeactive－进入后台background－失去焦点resignActive－挂起状态willTerminate
 
 //UIViewController生命周期
 viewWillAppear
 viewDidAppear
 viewWillDisappear : 当跳转到另一个视图时调用而进入后台时不会出发此方法
 viewDiddDiappear
 viewDidLoad
 viewWillLoad
 
 
 //通过self.storyboard.instantiateViewControllerWithIdentifier()来获取对应的控制器
 */

class SaveData: NSObject {
    //数据存储
    //1.沙盒
    let home = NSHomeDirectory()
    func test() {
        print("homePath = \(home)")
    }
    
    //2.目录结构
    
    //3.
}










