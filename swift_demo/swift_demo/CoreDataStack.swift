//
//  CoreDataStack.swift
//  swift_demo
//
//  Created by mac on 17/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataStack: NSObject {
    var mom: NSManagedObjectModel?
    var psc: NSPersistentStoreCoordinator?
    var moc: NSManagedObjectContext?
    var ps: NSPersistentStore?
    
    override init() {
        //获取到CoreData数据并用来实例化数据管理相关类
        
        //1.构建托管对象模型
        let main = NSBundle.mainBundle()
        let path = main.pathForResource("data", ofType: "momd")
        var url = NSURL(string: path!)
        url = main.URLForResource("data", withExtension: "momd")
        print(url!)
        mom = NSManagedObjectModel(contentsOfURL: url!)
        //2.构建持久化存储助理
        psc = NSPersistentStoreCoordinator(managedObjectModel: mom!)
        //3.构建托管对象上下文并将持久化存储助理绑定到上下文
        moc = NSManagedObjectContext(concurrencyType:.MainQueueConcurrencyType)
        moc!.persistentStoreCoordinator = psc
        //4.构建持久化存储
        let fm = NSFileManager.defaultManager()
        let urls = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docPathURL = urls.first!
        let storeURL = docPathURL.URLByAppendingPathComponent("data")
        
        do {ps = try psc?.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        }catch{
            print("创建持久化存储异常")
        }
    }
    private static var coreDataStack: CoreDataStack?
    static func getInstance() -> CoreDataStack {
        if coreDataStack == nil {
            coreDataStack = CoreDataStack()
        }
        return coreDataStack!
    }
    
    func saveContext() {
        if ((moc?.hasChanges) != nil) {
            do{
                try moc?.save()
            }catch{
                print("保存数据异常")
            }
        }
    }
}
