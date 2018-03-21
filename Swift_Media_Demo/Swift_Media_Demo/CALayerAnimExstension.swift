//
//  CALayerAnimExstension.swift
//  Swift_Media_Demo
//
//  Created by mac on 17/8/16.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

extension CALayer{
    func animateBaseKey(animName: NSString, fromValue: AnyObject, toValue: AnyObject, operatBlock:((animateReturnIsGroup: CABasicAnimation)->Bool)!) {
        var bAnim = CABasicAnimation(keyPath: animName as String)
        bAnim.fromValue = fromValue
        bAnim.toValue = toValue
        var isGroup: Bool = false
        if operatBlock != nil {
            isGroup = operatBlock(animateReturnIsGroup: bAnim)
        }
        if !isGroup {
            self.addAnimation(bAnim, forKey: String(animName))
        }
        
    }
}
