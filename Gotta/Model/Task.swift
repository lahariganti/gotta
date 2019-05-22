//
//  Task.swift
//  gotta
//
//  Created by Lahari Ganti on 2/10/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var dateCreated: Date?
    @objc dynamic var color: String = ""
    var category = LinkingObjects(fromType: Category.self, property: "tasks")
}
