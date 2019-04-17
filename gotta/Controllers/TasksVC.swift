//
//  TasksVC.swift
//  gotta
//
//  Created by Lahari Ganti on 2/7/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class TasksVC: SwipeTableVC {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    var tasks: Results<Task>?
    var selectedCategory: Category? {
        didSet {
            loadTasks()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        if let color = selectedCategory?.color {
            navigationController?.navigationBar.barTintColor = UIColor(hexString: color)
        }

        tableView.separatorStyle = .none


        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        addButton.tintColor = FlatBlack()
        navigationItem.rightBarButtonItem = addButton

        searchBar.delegate = self
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let task = tasks?[indexPath.row] {
            cell.textLabel?.text = task.title
            cell.accessoryType = task.isDone ? .checkmark : .none
            if let selectedCategoryColor = selectedCategory?.color {
                if let parentColor = UIColor(hexString: selectedCategoryColor) {
                    if let color = parentColor.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(tasks!.count)) {
                        cell.backgroundColor = color
                        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                    }
                }
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = tasks?[indexPath.row] {
            do {
                try realm.write {
                    task.isDone = !task.isDone
                }
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc func addButtonPressed() {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add to list", style: .default) { (action) in
            if let text = textField.text, let currentCategory = self.selectedCategory {
                if text.count > 0  {
                    do {
                        try self.realm.write {
                            let newTask = Task()
                            newTask.title = text
                            newTask.dateCreated = Date()
                            newTask.color = UIColor.randomFlat.hexValue()
                            currentCategory.tasks.append(newTask)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new task"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.view.tintColor = FlatBlack()
        present(alert, animated: true, completion: nil)

    }

    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    func loadTasks() {
        tasks = selectedCategory?.tasks.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

    override func updateModel(at indexPath: IndexPath) {
        if let taskToDelete = self.tasks?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(taskToDelete)
                }
            } catch {
                print(error)
            }
        }
    }
}

extension TasksVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            tasks = tasks?.filter("title CONTAINS [cd] %@", text).sorted(byKeyPath: "dateCreated", ascending: true)
        }
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadTasks()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
