//
//  TodoRemoteApi.swift
//  WordPress_Sdk
//
//  Created by Afsarunnisa on 25/01/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import idn_sdk_ios


open class TodoRemoteApi  {

    let baseWordpressUrl : String = "/wp-json/wp/v2"


    var todoUrl : String = ""
    var addTodoUrl : String = ""
    var updateTodoUrl : String = ""

    
    let networkAPI : NetworkApi!
    var apiContext : IdsIosApiContext!
    let clientTokenheaders : [String: String] = ["":""]

    
    init(httpClient: AnyObject) {
        
        apiContext = AbstractApiContext.get("app") as! IdsIosApiContext
        
//        let clientTokenModel : TokenApiModel = apiContext.getClientToken() as! TokenApiModel
//        let clientToken  = clientTokenModel.access_token
//        
//        clientTokenheaders = [
//            "Authorization": "Bearer \(clientToken)"
//        ]
        
        
        networkAPI = NetworkApi()
        
        
        todoUrl = "todos"
        addTodoUrl = "todo"
    }
    
    
    
    
    open func getTodos(completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
    
        let hostUrl : String = apiContext.getHost("todo")

        let connectUrl = "\(hostUrl)\(todoUrl)"

        networkAPI.get(connectUrl, paramsDict: [:], headers: [:], completionHandler: completionHandler)

    }
    
    
    open func getTodo(todoID: Int, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        
        let todosStr : String = "todo/\(todoID)"
        
        let hostUrl : String = apiContext.getHost("todo")
        
        let connectUrl = "\(hostUrl)\(todosStr)"

        networkAPI.get(connectUrl, paramsDict: [:], headers: [:], completionHandler: completionHandler)

        
    }
    
    
    func addTodo(todoDetails : Todo, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        let todosStr : String = "\(addTodoUrl)"

        let hostUrl : String = apiContext.getHost("todo")
        let connectUrl = "\(hostUrl)\(todosStr)"

        networkAPI.postWithEncode(connectUrl, paramsDict: Todo().getTodoDict(todo: todoDetails), headers: [:], completionHandler: completionHandler)

    }
    
    func updateTodo(todoID : Int, todoDetails : Todo, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        let todosStr : String = "updateTodo/\(todoID)"
        
        
        let hostUrl : String = apiContext.getHost("todo")
        
        let connectUrl = "\(hostUrl)\(todosStr)"
        
        networkAPI.postWithEncode(connectUrl, paramsDict: Todo().getTodoDict(todo: todoDetails), headers: [:], completionHandler: completionHandler)
        
        
    }
    
    
    func deleteTodo(todoID : Int, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        let todosStr : String = "todo/\(todoID)"
        let hostUrl : String = apiContext.getHost("todo")
        let connectUrl = "\(hostUrl)\(todosStr)"
        
        networkAPI.delete(connectUrl, paramsDict: [:], headers: [:], completionHandler: completionHandler)
        
        
    }
    

    
    
}

