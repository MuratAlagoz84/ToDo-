//
//  ViewController.swift
//  ToDo!
//
//  Created by Murat Alagöz on 31.07.2019.
//  Copyright © 2019 Murat Alagöz. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()

        }
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext



    override func viewDidLoad() {
        super.viewDidLoad()

        

        
        
    }
    
    //:MARK:- TableView DataCoruce Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
       
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveDataMethod()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPresses(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what Will hapen once the user Clicks the add item button on our UIAlert
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parrentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
            self.saveDataMethod()
            
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
    }
    
    // MARK: - Model Manipulation Methods
    
    func saveDataMethod() {
        
        
        do {
            
            
            try context.save()
            
        }
        catch{
            
            print("Error Saving Context \(error)")
            
        }
        self.tableView.reloadData()
        
    }
    func loadItems(whit request: NSFetchRequest<Item> = Item.fetchRequest(),predicade:NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parrentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicade{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        

       
        do{
       itemArray = try context.fetch(request)
        }
        catch{
            print("Error loading Items From context \(error)")
        }
        tableView.reloadData()
    }
    
    
    
}

// MARK: - Search Bar Methods

extension ToDoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(whit: request, predicade: predicate)


    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                
            searchBar.resignFirstResponder()
            }
            
           
        }
    }
}
