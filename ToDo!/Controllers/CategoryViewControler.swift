//
//  CategoryViewControler.swift
//  ToDo!
//
//  Created by Murat Alagöz on 4.08.2019.
//  Copyright © 2019 Murat Alagöz. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewControler: UITableViewController {
    
    var categoryArray = [Category]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // what Will hapen once the user Clicks the add item button on our UIAlert
            
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveDataMethod()
            
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
    }
    
    
    
    
    
    
    //MARK:-TableView Data Core Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
       cell.textLabel?.text = categoryArray[indexPath.row].name
        
        
        return cell
    }

    
    
    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
        destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - Data Manupulation Methods
    
    
    
    func saveDataMethod() {
        
        
        do {
            
            
            try context.save()
            
        }
        catch{
            
            print("Error Saving Context \(error)")
            
        }
        self.tableView.reloadData()
        
    }
    func loadCategory(whit request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        
        do{
            categoryArray = try context.fetch(request)
        }
        catch{
            print("Error loading Items From context \(error)")
        }
        tableView.reloadData()
    }
    
    
    
}

