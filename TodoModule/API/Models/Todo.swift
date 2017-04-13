//
//  Todo.swift
//  TodoApp
//
//  Created by Afsarunnisa on 27/02/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

open class Todo: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    public dynamic var id = 0
    public dynamic var title = ""
    public dynamic var todoDesc = ""

    
    override open static func primaryKey() -> String? {
        return "id"
    }
    
    
    public convenience init(json: JSON) {
        self.init()
        
        print("todo json \(json)")
        
        id = json["id"].intValue
        title = json["title"].stringValue
        todoDesc = json["description"].stringValue
        
    }
    
    open func getTodoDict(todo : Todo) -> Dictionary<String, Any>{
        
        if(todo.id != 0){
            return ["id" : todo.id as AnyObject, "title" : todo.title as AnyObject, "description" : todo.todoDesc as AnyObject]
        }else{
            return ["title" : todo.title as AnyObject, "description" : todo.todoDesc as AnyObject]

        }
        
    }


}
