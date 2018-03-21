//
//  Stu+CoreDataProperties.swift
//  swift_demo
//
//  Created by mac on 17/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Stu {

    @NSManaged var name: String?
    @NSManaged var sno: String?
    @NSManaged var score: NSNumber?

}
