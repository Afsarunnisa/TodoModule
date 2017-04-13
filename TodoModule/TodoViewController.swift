//
//  TodoViewController.swift
//  TodoApp
//
//  Created by Afsarunnisa on 12/04/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import UIKit
import idn_sdk_ios

class TodoViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!

    var updateTodo : Bool = false
    var todoVal : Todo!
   
    let todoApiClass : TodoApi.Type = IDS.getModuleApi("todo") as! TodoApi.Type

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        descTextView.layer.borderColor = UIColor.lightGray.cgColor
        descTextView.layer.borderWidth = 0.5
        descTextView.layer.cornerRadius = 2
        
        if(updateTodo == false){
            self.title = "Add Todo"
        }else{
            self.title = "Update Todo"
            
            titleTextField.text = todoVal.title
            descTextView.text = todoVal.todoDesc
        }
    }
    
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        
        if(titleTextField.text == ""){
            
            let alert = TodoModuleUtilities.alertView("Alert", alertMsg: "Please enter title", actionTitle: "Ok")
            self.present(alert, animated: true, completion: nil)
            
        }else if (descTextView.text == ""){
            
            
            let alert = TodoModuleUtilities.alertView("Alert", alertMsg: "Please enter description", actionTitle: "Ok")
            self.present(alert, animated: true, completion: nil)
            
        }else if(titleTextField.text != nil  && descTextView.text != nil){

            
            let todo : Todo = Todo()
            todo.title = titleTextField.text!
            todo.todoDesc = descTextView.text!

            let todoAPi = todoApiClass.init()

            
            if(updateTodo == false){
                

                todoAPi.addTodo(todoDetails: todo, responseHandler: {
                    
                    todosAry, messageApiModel, error in
                    
                    if(error != nil){
//                        _ = SweetAlert().showAlert("Message", subTitle: "\(error.debugDescription)", style: AlertStyle.none)
                    }else if(messageApiModel?.message != ""){
//                        _ = SweetAlert().showAlert("Message", subTitle: "\((messageApiModel?.message)!)", style: AlertStyle.none)
                    }else{
//                        _ = SweetAlert().showAlert("Todo", subTitle: "Todo added", style: AlertStyle.none)
                    }
                    
                })
            }else{
                
                todo.id = todoVal.id
 
                todoAPi.updateTodo(todoID: todoVal.id, todoDetails: todo, responseHandler: {
                    
                    todosAry, messageApiModel, error in
                    
                    if(error != nil){
//                        _ = SweetAlert().showAlert("Message", subTitle: "\(error.debugDescription)", style: AlertStyle.none)
                    }else if(messageApiModel?.message != ""){
//                        _ = SweetAlert().showAlert("Message", subTitle: "\((messageApiModel?.message)!)", style: AlertStyle.none)
                    }else{
//                        _ = SweetAlert().showAlert("Todo", subTitle: "Todo Updated", style: AlertStyle.none)
                    }
                    
                })
                
            }

            
        }

        
    }
}
