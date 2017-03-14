//
//  Restaurant.swift
//  FoodPin
//
//  Created by georgechang on 2015/6/4.
//  Copyright (c) 2015年 georgechang. All rights reserved.
//

import Foundation
import CoreData

class Restaurant:NSManagedObject {
    @NSManaged var name:String!
    @NSManaged var type:String!
    @NSManaged var location:String!
    @NSManaged var image:NSData!
    @NSManaged var isVisited:NSNumber!
}