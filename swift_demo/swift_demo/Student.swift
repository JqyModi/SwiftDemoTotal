//
//  Student.swift
//  swift_demo
//
//  Created by mac on 17/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation
//序列化一个对象
//1.实现NSCoding协议
class Student: NSObject, NSCoding {
    var name: String?
    var age: Int?
    
    override init() {
        super.init()
        print("无參构造")
    }
    
    init(name:String,age:Int) {
        self.name = name
        self.age = age
    }
    //2.实现encodeWithCoder方法
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(age, forKey: "age")
    }
    required init?(coder aDecoder: NSCoder) {
        aDecoder.decodeObjectForKey("name") as! String
        aDecoder.decodeObjectForKey("age") as! Int
    }
}
