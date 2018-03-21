//
//  main.swift
//  swift_demo_line
//
//  Created by mac on 17/8/5.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

print("Hello, World!")
//练习一
let f: Float = 4.3
let rs = f + 3
print(rs)

//UTF8及Unicode支持
let 变量名 = "varName"
print(变量名)
let 符号 = "😊"
print(符号)

//字符串拼接
var str = "拼接结果：\(符号)\(f)"
print(str)

//注释 :多行注释嵌套使用
/*
 外部注释
 /*
 内部注释
 */
*/

//分号的使用：当一行又多个语句时需要用分号分隔
var i = 2; print(i++); print(++i)

//基本数据类型:类型转换
let s1 = "2"
let s2 = "2.3"
let i1 = Int(s1)
let f1 = Float(s2)
print(i1)
print(f1)

//区别名:typeaalias 
typealias mStr = String
let ms: mStr = "Modi"
print(String)
print(mStr)
print(ms)

//元组：为什么设计元组？当函数需要返回一些复杂数据类型时，没有一个很方便的数据类型来描述／定义该返回结果，元组的出现则解决了这个问题
let obj = NSObject()
var yz = ("String",23,3.0,5.000,true,obj)
print(yz.0)
print(yz.5)
//将元组作为函数返回值（任意类型组合）
func getDatas(value: Int) -> (Int,String,Bool){
    var b = false
    if value == 0 {
        b = false
    }else{
        b = true
    }
    return (value,String(value),b)
}
var yz1 = getDatas(1)
print(yz1.0)
print(yz1.1)
print(yz1.2)

//
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







