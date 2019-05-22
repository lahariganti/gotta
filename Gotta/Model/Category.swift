//
//  Category.swift
//  gotta
//
//  Created by Lahari Ganti on 2/10/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let tasks = List<Task>()
}
