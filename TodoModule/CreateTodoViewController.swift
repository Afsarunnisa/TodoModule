//
//  CreateTodoViewController.swift
//  TodoSampleApp
//
//  Created by Afsarunnisa on 12/15/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import UIKit

class CreateTodoViewController: UIViewController {
    
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    var updateTodo : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        descriptionTextField.layer.borderWidth = 1
        descriptionTextField.layer.borderColor = UIColor.black.cgColor
        
        
        if(updateTodo == false){
            self.title = "Add Todo"
        }else{
            self.title = "Update Todo"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        
        if(titleTextField.text == ""){
            
            let alert = TodoUtilities.alertView("Alert", alertMsg: "Please enter title", actionTitle: "Ok")
            self.present(alert, animated: true, completion: nil)

        }else if (descriptionTextField.text == ""){
           
            
            let alert = TodoUtilities.alertView("Alert", alertMsg: "Please enter description", actionTitle: "Ok")
            self.present(alert, animated: true, completion: nil)
            
        }
        
        let title = titleTextField.text
        let description = descriptionTextField.text
        
        
        if(title != "" && description != ""){
            
            titleTextField.text = ""
            descriptionTextField.text = ""

            let alert = TodoUtilities.alertView("Alert", alertMsg: "To do added", actionTitle: "Ok")
            self.present(alert, animated: true, completion: nil)
            
        
        }
        
    }
}

