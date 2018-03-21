//
//  CustomCollectionViewFlowLayout.swift
//  Swift_MutableThread_Demo
//
//  Created by mac on 17/8/12.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    //调用系统的布局初始化方法:设置自定义的属性值
    override func prepareLayout() {
        super.prepareLayout()
    }
    //返回设置好的属性值
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return nil
    }
}
