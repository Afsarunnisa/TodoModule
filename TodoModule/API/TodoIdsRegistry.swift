//
//  TodoIdsRegistry.swift
//  WordPress_Sdk
//
//  Created by Afsarunnisa on 25/01/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import idn_sdk_ios

open class TodoIdsRegistry {
    
    public init(){
        IDS.register("todo", clazz: TodoApi.self)
    }
    
}
