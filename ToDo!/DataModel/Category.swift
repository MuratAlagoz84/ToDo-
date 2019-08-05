//
//  Category.swift
//  ToDo!
//
//  Created by Murat Alagöz on 5.08.2019.
//  Copyright © 2019 Murat Alagöz. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
