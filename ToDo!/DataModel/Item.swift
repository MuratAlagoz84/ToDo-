//
//  Item.swift
//  ToDo!
//
//  Created by Murat Alagöz on 5.08.2019.
//  Copyright © 2019 Murat Alagöz. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    
}
