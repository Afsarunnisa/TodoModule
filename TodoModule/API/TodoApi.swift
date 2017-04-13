//
//  TodoApi.swift
//  WordPress_Sdk
//
//  Created by Afsarunnisa on 25/01/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import idn_sdk_ios
import SwiftyJSON
import RealmSwift


open class TodoApi : NetworkApi {
    
    
    required public init() {
        super.init()
        setModuleName("todo")
        setRemoteApiClass(TodoRemoteApi.self)
    }
    
    
    open func getTodos(responseHandler: @escaping (NSArray?, MessagesApiModel?, NSError?) -> ()) {
    
    
        let remoteAPI : TodoRemoteApi = TodoRemoteApi(httpClient: self)

        
        remoteAPI.getTodos(completionHandler: {
            
            responseObject,statusCode, error in
            
            var messageApiModel : MessagesApiModel = MessagesApiModel()

            if(error == nil){
                let swiftyJsonVar = JSON(responseObject as Any)
                print("swiftyJsonVar \(swiftyJsonVar)")
                
                if(statusCode == 200){
                    self.todosEntity(todos: swiftyJsonVar)
                    
                }else if(statusCode == 400){
                    messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
                }else {
                    messageApiModel.message = swiftyJsonVar["message"].string!
                    messageApiModel.messageCode = swiftyJsonVar["messageCode"].string!
                }
            }
            
            responseHandler(NSArray(),messageApiModel, error)
            
            
        })
    }
    
    
    open func getTodo(todoID : String,responseHandler: @escaping (NSArray?, MessagesApiModel?, NSError?) -> ()) {
    
        let remoteAPI : TodoRemoteApi = TodoRemoteApi(httpClient: self)

        remoteAPI.getTodo(todoID: Int(todoID)!, completionHandler: {
            
            responseObject,statusCode, error in
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            print("swiftyJsonVar \(swiftyJsonVar)")
            
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            
            if(statusCode == 200){
            
                
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                messageApiModel.message = swiftyJsonVar["message"].string!
                messageApiModel.messageCode = swiftyJsonVar["messageCode"].string!
            }
            
            responseHandler(NSArray(),messageApiModel, error)
            
        })
    }
    
    
    
    open func addTodo(todoDetails : Todo, responseHandler: @escaping (NSArray?, MessagesApiModel?, NSError?) -> ()){
        
        let remoteAPI : TodoRemoteApi = TodoRemoteApi(httpClient: self)


        remoteAPI.addTodo(todoDetails: todoDetails, completionHandler: {
            
            responseObject,statusCode, error in
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            print("swiftyJsonVar \(swiftyJsonVar)")
            
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            
            if(statusCode == 200){
                
                
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                messageApiModel.message = swiftyJsonVar["message"].string!
                messageApiModel.messageCode = swiftyJsonVar["messageCode"].string!
            }
            
            responseHandler(NSArray(),messageApiModel, error)
            
            
        })
        
    }
    
    
    open func updateTodo(todoID : Int, todoDetails : Todo, responseHandler: @escaping (NSArray?, MessagesApiModel?, NSError?) -> ()){
        
        let remoteAPI : TodoRemoteApi = TodoRemoteApi(httpClient: self)
        
        
        remoteAPI.updateTodo(todoID: todoID, todoDetails: todoDetails, completionHandler: {
            
            responseObject,statusCode, error in
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            print("swiftyJsonVar \(swiftyJsonVar)")
            
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            
            if(statusCode == 200){
                
                
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                messageApiModel.message = swiftyJsonVar["message"].string!
                messageApiModel.messageCode = swiftyJsonVar["messageCode"].string!
            }
            
            responseHandler(NSArray(),messageApiModel, error)
            
        })
    }

    
    open func deleteTodo(todoID : Int,  responseHandler: @escaping (NSArray?, MessagesApiModel?, NSError?) -> ()){
        
        let remoteAPI : TodoRemoteApi = TodoRemoteApi(httpClient: self)
        
        
        remoteAPI.deleteTodo(todoID: todoID, completionHandler: {
            
            responseObject,statusCode, error in
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            print("swiftyJsonVar \(swiftyJsonVar)")
            
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            
            if(statusCode == 200){
                
                
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                messageApiModel.message = swiftyJsonVar["message"].string!
                messageApiModel.messageCode = swiftyJsonVar["messageCode"].string!
            }
            
            responseHandler(NSArray(),messageApiModel, error)
            
            
        })
        
    }
    
    
        
    
    
    func getMessageFromDict(msgDict : JSON) -> MessagesApiModel{
        
        let messageApiModel : MessagesApiModel = MessagesApiModel()
        let errorsAry: Array<JSON> = msgDict["errors"].arrayValue
        
        messageApiModel.message = errorsAry[0]["message"].string!
        messageApiModel.messageCode = errorsAry[0]["messageCode"].string!
        
        return messageApiModel
    }
    
    
    
    
    func todosEntity(todos : JSON){
        
        let realm = try! Realm()
        
        let list: Array<JSON> = todos["todos"].arrayValue
        
        try! realm.write({
            
            let todos = List<Todo>(list.map(Todo.init))
            realm.add(List(todos), update: true)
            
        })
    }
    
    
}
