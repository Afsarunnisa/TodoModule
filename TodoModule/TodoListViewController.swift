//
//  TodoListViewController.swift
//  TodoSampleApp
//
//  Created by Afsarunnisa on 12/15/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import UIKit

public class TodoListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var todoListTableview: UITableView!
    var isUpdating : Bool = false
    
    let arrayList : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    
    override public func viewDidLoad() {
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
    
    
    public func menuAction(imgName: String, menuView : AnyObject, completionHandler: @escaping (UIBarButtonItem?, NSError?) -> ()) {
        
        if menuView != nil {
            menuButton.target = menuView
            self.view.addGestureRecognizer(menuView.panGestureRecognizer)
        }
        
        completionHandler(menuButton, nil)
    }
    
    
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        // Adding the right informations
        cell.textLabel?.text = arrayList.object(at: indexPath.row) as? String
        
        // Returning the cell
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        isUpdating = true
        self.performSegue(withIdentifier: "listToDetails", sender: self)
    }
    
    
    
    @IBAction func addTodo(_ sender: Any) {
        isUpdating = false
        self.performSegue(withIdentifier: "listToDetails", sender: self)
    }
    
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "listToDetails" {
            let targetController : CreateTodoViewController  = segue.destination as! CreateTodoViewController
            targetController.updateTodo = isUpdating
        }
    }
}

