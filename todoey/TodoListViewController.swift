//
//  ViewController.swift
//  todoey
//
//  Created by Kamran Shaikh on 19/11/2018.
//  Copyright © 2018 Kamran Shaikh. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var ItemArray = [item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newitem = item()
        newitem.title = "Find mike"
        ItemArray.append(newitem)
        
        let newitem2 = item()
        newitem2.title = "Buy Eggos"
        ItemArray.append(newitem2)
        
        let newitem3 = item()
        newitem3.title = "Destroy Demogorgon"
        ItemArray.append(newitem3)
  
        if let items = defaults.array(forKey: "ToDoListArray") as? [item] {
            ItemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        print("CellForRowAtIndexPath Called")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        
        let Item = ItemArray[indexPath.row]
        cell.textLabel?.text = Item.title
        
        cell.accessoryType = Item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        ItemArray[indexPath.row].done = !ItemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    // add items
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController.init(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = item()
            newItem.title = textField.text!
            self.ItemArray.append(newItem)
            
            self.defaults.setValue(self.ItemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }


        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

