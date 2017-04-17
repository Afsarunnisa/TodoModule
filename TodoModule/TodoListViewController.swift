//
//  ViewController.swift
//  TodoApp
//
//  Created by Afsarunnisa on 27/02/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON
import Realm
import idn_sdk_ios

class TodoListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var todosTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    let searchController = UISearchController(searchResultsController: nil)
    var todos : Array<Any>! = []
    var isUpdating : Bool = false
    var selectedTodo : Todo! = nil
    
    override func viewDidLoad() {

        let app_context = IdsIosApiContext.init(name: "app")
        _ = IdnSDK.init(apiContext: app_context)
        
        _ = TodoIdsRegistry()
        super.viewDidLoad()
        
        
        var recognizer = UISwipeGestureRecognizer(target: self, action: "didSwipe")
        self.todosTableView.addGestureRecognizer(recognizer)

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let todoApiClass : TodoApi.Type = IDS.getModuleApi("todo") as! TodoApi.Type
        let todoAPi = todoApiClass.init()
        
        todoAPi.getTodos(responseHandler: {
            todosAry, messageApiModel, error in
            
            if(error != nil){
                
                let alert = TodoModuleUtilities.alertView("Message", alertMsg: "\(error.debugDescription)", actionTitle: "OK")
                self.present(alert, animated: true, completion: nil)

            }else if(messageApiModel?.message != ""){
                let alert = TodoModuleUtilities.alertView("Message", alertMsg: "\(error.debugDescription)", actionTitle: "OK")
                self.present(alert, animated: true, completion: nil)
            }else{
                self.todosTableView.reloadData()
            }
        })
    }
    
    
    func didSwipe(recognizer: UIGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Ended {
            let swipeLocation = recognizer.locationInView(self.tableView)
            if let swipedIndexPath = tableView.indexPathForRowAtPoint(swipeLocation) {
                if let swipedCell = self.tableView.cellForRowAtIndexPath(swipedIndexPath) {
                    // Swipe happened. Do stuff!
                }
            }
        }
    }
    
    
    public func menuAction(imgName: String, menuView : AnyObject, completionHandler: @escaping (UIBarButtonItem?, NSError?) -> ()) {
        
        //        if menuView != nil {
        menuButton.target = menuView
        self.view.addGestureRecognizer(menuView.panGestureRecognizer)
        //        }
        
        completionHandler(menuButton, nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Tableview delegate Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        
        let realm = try! Realm()

        if(searchController.isActive && searchController.searchBar.text != ""){
            
            let predicate = NSPredicate(format: "title contains[c] %@", searchController.searchBar.text!)
            
            let filterdObjects = realm.objects(Todo.self)
            let filterdList = filterdObjects.filter(predicate)
            self.todos = Array(filterdList)
            
        }else{
            
            let filterdObjects = realm.objects(Todo.self)
            self.todos = Array(filterdObjects)
            
        }
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodolistCell
        let todo : Todo = todos[indexPath.row] as! Todo
        
        return cell.bind(todo: todo)
    }

    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        isUpdating = true
        selectedTodo = todos[indexPath.row] as! Todo

        
        self.performSegue(withIdentifier: "listToDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            
            let todo : Todo = todos[indexPath.row] as! Todo

        
            let todoApiClass : TodoApi.Type = IDS.getModuleApi("todo") as! TodoApi.Type
            let todoAPi = todoApiClass.init()

            todoAPi.deleteTodo(todoID: todo.id, responseHandler: {
                todosAry, messageApiModel, error in
                
                if(error != nil){
                    let alert = TodoModuleUtilities.alertView("Message", alertMsg: "\(error.debugDescription)", actionTitle: "OK")
                    self.present(alert, animated: true, completion: nil)
                }else if(messageApiModel?.message != ""){
                    let alert = TodoModuleUtilities.alertView("Message", alertMsg: "\(error.debugDescription)", actionTitle: "OK")
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.deleteRowAtIndexPath(indexPath: indexPath as NSIndexPath)
                }
            })
            
        }
    }
    
    func deleteRowAtIndexPath(indexPath: NSIndexPath){
        let realm = try! Realm()
       
        let objectToDelete : Todo = todos[indexPath.row] as! Todo

        
        try! realm.write({
            realm.delete(objectToDelete)
        })
        
        todosTableView.deleteRows(at: [indexPath as IndexPath], with: .fade) //7
    }

    

    @IBAction func addTodo(_ sender: Any) {
        isUpdating = false
        self.performSegue(withIdentifier: "listToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "listToDetails"){
            
            let destinationVC = segue.destination as! TodoViewController
            destinationVC.todoVal = selectedTodo
            destinationVC.updateTodo = isUpdating

        }
    }
}
