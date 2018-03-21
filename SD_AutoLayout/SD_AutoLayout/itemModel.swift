//
//  itemModel.swift
//  SD_AutoLayout
//
//  Created by mac on 17/9/23.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class itemModel: NSObject {
    var content: String?
    var imageName: String?
    
    init(str: String, imgName: String) {
        content = str
        imageName = imgName
    }
}
