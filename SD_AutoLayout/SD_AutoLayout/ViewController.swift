//
//  ViewController.swift
//  SD_AutoLayout
//
//  Created by mac on 17/9/22.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView?
    
    var models: [itemModel]?
    
    let Identifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        
        setupTableView()
        
    }

    func setupTableView(){
        tableView = UITableView(frame: self.view.frame)
        tableView?.dataSource = self
        tableView?.delegate = self
        //
        tableView?.register(AutoViewCell.classForCoder(), forCellReuseIdentifier: Identifier)
        
        tableView?.tableFooterView = UIView()
        tableView?.backgroundColor = UIColor.gray
        self.view.addSubview(tableView!)
    }

    func loadData(){
        let str1 = "fdsjalfdkslkafdlsaj减肥的零食减肥动力升级的撒发的路上啊减肥了点撒费拉达斯发低烧了饭了撒风"
        let str2 = "金德拉克精神分裂的撒娇奋斗了发低烧了几分灯笼裤撒娇费拉达斯啊减肥了点撒肌肤看到了撒娇发来的撒肌肤大量时间啊发来的撒酒疯了撒娇发来的撒娇发来的及撒了风刀霜剑啊浪费的就是阿里附近的沙拉"
        let str3 = "封疆大吏手机放到了撒娇发来的撒娇啊大家深刻理解发低烧了句JFDSLJFLDSJ加拉加斯发了附近的路上啊减肥JDLSJFLJDSLKJ费德勒睡觉啊疯了"
        let str4 = "fkldsajf dsajfioj累计发电量撒娇发电量数据反对撒辣椒粉的路上fdsalfj aljfd fdslj哦就反对撒辣椒粉啊失联飞机拉萨肌肤"
        let str5 = "fdsjalfdkslkafdlsaj减肥的零食减肥动力升级的撒发的路上啊减肥了点撒费拉达斯发低烧了饭了撒风"
        let str6 = "金德拉克精神分裂的撒娇奋斗了发低烧了几分灯笼裤撒娇费拉达斯啊减肥了点撒肌肤看到了撒娇发来的撒肌肤大量时间啊发来的撒酒疯了撒娇发来的撒娇发来的及撒了风刀霜剑啊浪费的就是阿里附近的沙拉"
        let str7 = "封疆大吏手机放到了撒娇发来的撒娇啊大家深刻理解发低烧了句JFDSLJFLDSJ加拉加斯发了附近的路上啊减肥JDLSJFLJDSLKJ费德勒睡觉啊疯了"
        let str8 = "fkldsajf dsajfioj累计发电量撒娇发电量数据反对撒辣椒粉的路上fdsalfj aljfd fdslj哦就反对撒辣椒粉啊失联飞机拉萨肌肤"
        
        models = [itemModel]()
        models?.append(itemModel(str: str1, imgName: "icon0.jpg"))
        models?.append(itemModel(str: str2, imgName: "icon1.jpg"))
        models?.append(itemModel(str: str3, imgName: "icon2.jpg"))
        models?.append(itemModel(str: str4, imgName: "icon3.jpg"))
        models?.append(itemModel(str: str5, imgName: "icon4.jpg"))
        models?.append(itemModel(str: str6, imgName: "pic0.jpg"))
        models?.append(itemModel(str: str7, imgName: ""))
        models?.append(itemModel(str: str8, imgName: "pic2.jpg"))
        
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (models?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Identifier) as? AutoViewCell
//        if cell == nil {
//            cell = AutoViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: Identifier)
//        }else{
//            for item in (cell?.contentView.subviews)! {
//                item.removeFromSuperview()
//            }
//        }
        
        if cell != nil {
            cell = AutoViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: Identifier)
        }
        
        cell?.setModel(model: (models?[indexPath.row])!)
        
//        cell?.model = itemModel(str: (strs?[indexPath.row])!)
//        cell?.model = models?[indexPath.row]
        
        cell?.useCellFrameCache(with: indexPath, tableView: tableView)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        return tableView.cellHeight(for: indexPath, model: models![indexPath.row], keyPath: "model", cellClass: AutoViewCell.classForCoder(), contentViewWidth: UIScreen.main.bounds.size.width)
        return tableView.cellHeight(for: indexPath, cellContentViewWidth: UIScreen.main.bounds.size.width, tableView: tableView)
    }
}
