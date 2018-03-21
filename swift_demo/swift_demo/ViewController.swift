//
//  ViewController.swift
//  swift_demo
//
//  Created by mac on 17/8/5.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        label.text = "请选择所有的中国名胜古迹"
        
        
        //数据存储
        //1.沙盒目录
        var home = NSHomeDirectory()
        print("homePath = \(home)")
        //2.document目录
        home = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        print("documentPath = \(home)")
        //3.library目录
        home = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true).first!
        print("libraryPath = \(home)")
        //4.Cache目录
        home = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first!
        print("cachePath = \(home)")
        //5.tmp目录
        home = NSTemporaryDirectory()
        print("tempPath = \(home)")
        
        //文件及目录操作:FileManager
        
        //用户首选项:UserDefault:存储用户信息及应用配置信息
        let userDef = NSUserDefaults.standardUserDefaults()
        userDef.setObject(NSDate(), forKey: "rDate")
        //相当于提交操作：可以省略系统完成
        userDef.synchronize()
        
        //属性列表：.plist文件： 读写当做一个文件来操作即可：如可以通过数组／字典的writeToFile来写入文件
        
        //编码对象：NSCoder -> 构建需要归档的对象 -> 编码／解码 ＝ 序列化／反序列化 ＝ 归档／解档
        let path = "/Users/mac/Desktop"
        let stu = Student(name: "modi", age: 23)
        //由于Student没有序列化故无法进行归档操作
        //归档
        var data = NSKeyedArchiver.archivedDataWithRootObject(stu)
        let b = data.writeToFile(path+"/modi.archiver", atomically: true)
        if b {
            print("success")
        }else{
            print("failed")
        }
        
        //解档
        data = NSData.dataWithContentsOfMappedFile(path+"/modi.archiver") as! NSData
        
        
        //创建数据库
        var db: COpaquePointer = nil
        
        let rs =  sqlite3_open(path+"/modi.sqlite3", &db)
        if rs == SQLITE_OK {
            print("数据库创建成功")
        }else{
            print("数据库创建失败")
        }
        //创建数据表
        var sql = "create table if not exists list(id integer primary key autoincrement,name char,sex char)";
        var error: UnsafeMutablePointer<Int8>?
//        const char *createSQL = "create table if not exists list(id integer primary key autoincrement,name char,sex char)";
        var exe: Int32;
//        exe = sqlite3_exec(db, sql, nil, nil, &error!)
//        
//        if exe == SQLITE_OK {
//            print("数据表创建成功")
//        }else{
//            print("数据表创建失败")
//        }
        //向数据表中插入数据
        sql = "insert into list (name,sex) values('girl','女');"
        exe = sqlite3_exec(db, sql, nil, nil, nil)
        if exe == SQLITE_OK {
            print("数据插入成功")
        }else{
            print("数据插入失败")
        }
        //删除数据同上
        //更新数据同上
        //关闭数据库
        sqlite3_close(db);
        
        //Core Data: 对sqlite的封装减小开发难度
        //持久存储栈
        
        //Core Data 数据操作：增删改查
        //插入数据
//        insertData()
        //删除数据
        deleteData()
        selectData()
        //更新数据
        updateData()
        //查询数据
        selectData()
        //求平均分
        avgData()
        
        //多点触控与手势识别：事件传递机制：大 -> 小[小到该控件的下一级内部没有子控件时循环判断当前触发事件的点位置（Location）在哪个子控件上：firstResponder] 处理？回传结果：回传处理
//        系统识别机制：电容屏：通过电流是否受阻来判断当前时刻是否发生触摸事件 ：滑动其实是无数次点击的组合效果
        
        //手势识别两种方式：可以设置点击次数及触摸点个数(手指触摸个数)
        //1.编码实现
        //创建手势
        
        //将手势添加到view上
        
        //实现手势响应事件Action
        
        
        //2.storyboard实现
        
        //给greenView添加自定义手势
        let customGR = UICostomGestureRecongnizer(target: self, action: "customGesture:")
        self.greenView.addGestureRecognizer(customGR)
        
        //实现一个趣味验证码Demo:待实现
        //添加第一排图片
//        for item in 0...4 {
//            
//        }
        //添加第二排图片
//        for item in 0...4 {
//            
//        }
        
        //原生网络访问获取资源数据:http://shiyan360.cn/index.php/api/examinPaperDetail?id=1
        //创建URL
        let url = NSURL(string: "http://shiyan360.cn/index.php/api/examinPaperDetail?id=1")
        //创建请求对象
        let request = NSURLRequest(URL: url!)
        //异步请求:去掉A就是同步请求:
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (responder, data, error) in
            if error == nil {
                //得到二进制文件
                print("data = \(data?.description)")
                //序列化
                do{
//                    NSJSONReadingMutableContainers：返回可变容器，NSMutableDictionary或NSMutableArray。
//                    NSJSONReadingMutableLeaves：返回的JSON对象中字符串的值为NSMutableString，目前在iOS 7上测试不好用，应该是个bug，参见：
//                    http://stackoverflow.com/questions/19345864/nsjsonreadingmutableleaves-option-is-not-working
//                    NSJSONReadingAllowFragments：允许JSON字符串最外层既不是NSArray也不是NSDictionary，但必须是有效的JSON Fragment。例如使用这个选项可以解析 @“123” 这样的字符串。参见：
//                    http://stackoverflow.com/questions/16961025/nsjsonserialization-nsjsonreadingallowfragments-reading
//                    NSJSONWritingPrettyPrinted：的意思是将生成的json数据格式化输出，这样可读性高，不设置则输出的json字符串就是一整行
                    let serialization = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    if ((serialization as? NSDictionary) != nil) {
                        let msg = serialization.valueForKey("message")
                        print("msg = \(msg)")
                        //
                        let xcontent = serialization.valueForKey("xcontent") as? NSDictionary
                        if (xcontent != nil) {
                            print("xcontent = \(xcontent?.description)")
                            let one = xcontent?.valueForKey("1") as? NSDictionary
                            if (one != nil) {
                                print("one = \(one?.description)")
                                let title = one?.valueForKey("title") as? NSString
                                if (title != nil) {
                                    print("title = \(title?.description)")
                                }
                            }
                        }
                    }
                }catch{
                    
                }
                
                
                
            }
            
        }

        
    }
    
    
    
    
    func customGesture(sender: UICostomGestureRecongnizer) {
        print("自定义手势识别器响应回调")
    }
    

    func insertData() -> Bool {
        let moc = CoreDataStack.getInstance().moc
        let psc = moc?.persistentStoreCoordinator
        let stu = NSEntityDescription.insertNewObjectForEntityForName("Stu", inManagedObjectContext: moc!) as! Stu
        stu.name = "modi"
        stu.sno = "2013070608"
        stu.score = 80
        for item in 0...10 {
            let stu = NSEntityDescription.insertNewObjectForEntityForName("Stu", inManagedObjectContext: moc!) as! Stu
            stu.name = "modi_\(item)"
            stu.sno = "2013070608_\(item)"
            stu.score = 80 + item
        }
        
        
        do {
            try moc?.save()
            print("数据保存成功")
            return true
        }catch{
            print("保存数据异常")
            return false
        }
        return false
    }
    //删除数据：先将需要删除数据查询出来通过上下文删除保存即可
    func deleteData() -> Bool {
        //获取上下文
        let moc = CoreDataStack.getInstance().moc
        //构建实体关联抓取对象
        let request = NSFetchRequest(entityName: "Stu")
        //指定返回结果类型:字典等
        //        request.resultType = .DictionaryResultType
        //设置查询条件：如按sno升降序、平均值、最大、小值、sno>3等
        
        request.sortDescriptors = [NSSortDescriptor(key: "sno", ascending: true)]
        request.predicate = NSPredicate(format: "sno = 80")
        
        do{
            let stu = try moc?.executeFetchRequest(request) as! [Stu]
            for item in stu {
                moc?.deleteObject(item)
            }
            //保存删除操作
            CoreDataStack.getInstance().saveContext()
            print("删除数据成功")
        }catch{
            print("删除数据失败")
        }
        return false
    }
    //修改数据：先将需要修改数据查询出来直接修改保存即可
    func updateData() -> Bool {
        //获取上下文
        let moc = CoreDataStack.getInstance().moc
        //构建实体关联抓取对象
        let request = NSFetchRequest(entityName: "Stu")
        //指定返回结果类型:字典等
        //        request.resultType = .DictionaryResultType
        //设置查询条件：如按sno升降序、平均值、最大、小值、sno>3等
        
        request.sortDescriptors = [NSSortDescriptor(key: "sno", ascending: true)]
        request.predicate = NSPredicate(format: "score = 80")
        
        do{
            let stu = try moc?.executeFetchRequest(request) as! [Stu]
            for item in stu {
                item.name = "Alise"
                item.score = 100
                item.sno = "2013070620"
            }
            //保存删除操作
            CoreDataStack.getInstance().saveContext()
            print("修改数据成功")
        }catch{
            print("修改数据失败")
        }
        return false
    }
    func selectData() -> Bool {
        //获取上下文
        let moc = CoreDataStack.getInstance().moc
        //构建实体关联抓取对象
        let request = NSFetchRequest(entityName: "Stu")
        //指定返回结果类型:字典等
//        request.resultType = .DictionaryResultType
        //设置查询条件：如按sno升降序、平均值、最大、小值、sno>3等
        
        request.sortDescriptors = [NSSortDescriptor(key: "sno", ascending: true)]
//        request.predicate = NSPredicate(format: "sno = 2013070608")
        
        do{
            let stu = try moc?.executeFetchRequest(request) as! [Stu]
            for item in stu {
                print("item:name = "+item.name!+" sno = \(item.sno)  score = \(item.score)")
            }
        }catch{
            print("查询数据失败")
        }
        
        return false
    }
    //利用系统函数求平均值
    func avgData(){
        //获取上下文
        let moc = CoreDataStack.getInstance().moc
        //构建实体关联抓取对象
        let request = NSFetchRequest(entityName: "Stu")
        //指定返回结果类型:字典等
        request.resultType = .DictionaryResultType
        //构建约束表达式
        let expd = NSExpressionDescription()
        expd.name = "Avg"
        let args = [NSExpression(forKeyPath: "score")]
        
        //系统支持的方法列表:每个方法调用需带上:
        
        // Predefined functions are:
        // name              parameter array contents				returns
        //-------------------------------------------------------------------------------------------------------------------------------------
        // sum:              NSExpression instances representing numbers		NSNumber
        // count:            NSExpression instances representing numbers		NSNumber
        // min:              NSExpression instances representing numbers		NSNumber
        // max:              NSExpression instances representing numbers		NSNumber
        // average:          NSExpression instances representing numbers		NSNumber
        // median:           NSExpression instances representing numbers		NSNumber
        // mode:             NSExpression instances representing numbers		NSArray	    (returned array will contain all occurrences of the mode)
        // stddev:           NSExpression instances representing numbers		NSNumber
        // add:to:           NSExpression instances representing numbers		NSNumber
        // from:subtract:    two NSExpression instances representing numbers	NSNumber
        // multiply:by:      two NSExpression instances representing numbers	NSNumber
        // divide:by:        two NSExpression instances representing numbers	NSNumber
        // modulus:by:       two NSExpression instances representing numbers	NSNumber
        // sqrt:             one NSExpression instance representing numbers		NSNumber
        // log:              one NSExpression instance representing a number	NSNumber
        // ln:               one NSExpression instance representing a number	NSNumber
        // raise:toPower:    one NSExpression instance representing a number	NSNumber
        // exp:              one NSExpression instance representing a number	NSNumber
        // floor:            one NSExpression instance representing a number	NSNumber
        // ceiling:          one NSExpression instance representing a number	NSNumber
        // abs:              one NSExpression instance representing a number	NSNumber
        // trunc:            one NSExpression instance representing a number	NSNumber
        // uppercase:	 one NSExpression instance representing a string	NSString
        // lowercase:	 one NSExpression instance representing a string	NSString
        // random            none							NSNumber (integer)
        // randomn:          one NSExpression instance representing a number	NSNumber (integer) such that 0 <= rand < param
        // now               none							[NSDate now]
        // bitwiseAnd:with:	 two NSExpression instances representing numbers	NSNumber    (numbers will be treated as NSInteger)
        // bitwiseOr:with:	 two NSExpression instances representing numbers	NSNumber    (numbers will be treated as NSInteger)
        // bitwiseXor:with:	 two NSExpression instances representing numbers	NSNumber    (numbers will be treated as NSInteger)
        // leftshift:by:	 two NSExpression instances representing numbers	NSNumber    (numbers will be treated as NSInteger)
        // rightshift:by:	 two NSExpression instances representing numbers	NSNumber    (numbers will be treated as NSInteger)
        // onesComplement:	 one NSExpression instance representing a numbers	NSNumber    (numbers will be treated as NSInteger)
        // noindex:		 an NSExpression					parameter   (used by CoreData to indicate that an index should be dropped)
        // distanceToLocation:fromLocation:
        //                   two NSExpression instances representing CLLocations    NSNumber
        // length:           an NSExpression instance representing a string         NSNumber
        expd.expression = NSExpression(forFunction: "average:", arguments: args)
        //指定返回值类型
        expd.expressionResultType = .FloatAttributeType
        request.propertiesToFetch = [expd]
        do{
            let model = try moc?.executeFetchRequest(request)
            let results = model?.first! as! NSDictionary
            //通过上面设置的name来获取平均值
            let avg = results["Avg"]
            print("avg = \(avg)")
        }catch{
            print("查询数据失败")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

