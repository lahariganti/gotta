//
//  CategoryVC.swift
//  gotta
//
//  Created by Lahari Ganti on 2/9/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryVC: SwipeTableVC {
    var categories: Results<Category>?
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        tableView.separatorStyle = .none

        navigationController?.navigationBar.barTintColor = FlatWhite()
        navigationController?.navigationBar.tintColor = FlatBlack()
        navigationController?.navigationBar.prefersLargeTitles = true

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        addButton.tintColor = FlatBlack()
        navigationItem.rightBarButtonItem = addButton

        loadCategories()
    }

    @objc func addButtonPressed() {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add to the list of categories", style: .default) { (action) in
            if let text = textField.text {
                if text.count > 0 {
                    let newCategory = Category()
                    newCategory.name = text
                    newCategory.color = UIColor.randomFlat.hexValue()
                    self.save(category: newCategory)
                }
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new task"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.view.tintColor = FlatBlack()
        present(alert, animated: true, completion: nil)

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            if let color = UIColor(hexString: category.color) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let tasksVC = TasksVC()
            if let categories: Results<Category> = categories {
                tasksVC.selectedCategory = categories[indexPath.row]
                self.navigationController?.pushViewController(tasksVC, animated: true)
            }
        }
    }

    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }

    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }

    override func updateModel(at indexPath: IndexPath) {
        if let categoryToDelete = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryToDelete)
                }
            } catch {
                print(error)
            }
        }
    }
}
