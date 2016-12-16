//
//  TodoListViewController.swift
//  TodoSampleApp
//
//  Created by Afsarunnisa on 12/15/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var todoListTableview: UITableView!
    var isUpdating : Bool = false
    
    let arrayList : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Todos list"
        
        arrayList.add("test")
        arrayList.add("test")
        arrayList.add("test")
        arrayList.add("test")
        arrayList.add("test")
        arrayList.add("test")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        // Adding the right informations
        cell.textLabel?.text = arrayList.object(at: indexPath.row) as? String
        
        // Returning the cell
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
   
        isUpdating = true
        self.performSegue(withIdentifier: "listToDetails", sender: self)
    }
    

    
    @IBAction func addTodo(_ sender: Any) {
        
        isUpdating = false
        self.performSegue(withIdentifier: "listToDetails", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "listToDetails" {
            let targetController : CreateTodoViewController  = segue.destination as! CreateTodoViewController
            targetController.updateTodo = isUpdating
        }
    }
}

