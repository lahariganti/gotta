//
//  Helpers.swift
//  gotta
//
//  Created by Lahari Ganti on 2/7/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import Foundation

class Helpers {
    class func generateTasks(tasks: inout [Task]) {
        let task1 = Task()
        task1.title = "task1"
        task1.isDone = true

        let task2 = Task()
        task2.title = "task2"

        let task3 = Task()
        task3.title = "task3"

        let task4 = Task()
        task4.title = "task4"

        let task5 = Task()
        task5.title = "task5"

        let task6 = Task()
        task6.title = "task6"

        for task in [task1, task2, task3, task4, task5] {
            tasks.append(task)
        }
    }
}
