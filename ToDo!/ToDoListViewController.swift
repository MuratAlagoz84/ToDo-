//
//  ViewController.swift
//  ToDo!
//
//  Created by Murat Alagöz on 31.07.2019.
//  Copyright © 2019 Murat Alagöz. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    let itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon","Kill The Monster"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }

        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPresses(_ sender: UIBarButtonItem) {
        
        
        let alert = UIAlertController(title: "Add New To Do Button", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what Will hapen once the user Clicks the add item button on our UIAlert
            print("Sucess")
        }
        
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
    }
    
}

