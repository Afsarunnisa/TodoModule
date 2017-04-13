//
//  TodolistCell.swift
//  TodoApp
//
//  Created by Afsarunnisa on 01/03/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import UIKit


class TodolistCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    public func bind(todo : Todo) -> Self {

        titleLabel.text = todo.title
        descLabel.text = todo.todoDesc
        
        return self
    }
    

}
