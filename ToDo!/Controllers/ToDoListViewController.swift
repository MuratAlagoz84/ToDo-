//
//  ViewController.swift
//  ToDo!
//
//  Created by Murat Alagöz on 31.07.2019.
//  Copyright © 2019 Murat Alagöz. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let deafults = UserDefaults.standard
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.tittle = "Find Mike"
        itemArray.append(newItem)
        
        
        let newItem2 = Item()
        newItem2.tittle = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.tittle = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        
        if let items = deafults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
        }

//        print(itemArray)
//
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = item.tittle
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
       
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPresses(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what Will hapen once the user Clicks the add item button on our UIAlert
            
            
            let newItem = Item()
            newItem.tittle = textField.text!
            
            self.itemArray.append(newItem)
            
            
            self.deafults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
    }
    
}

