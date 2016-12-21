//
//  TodoFramework.swift
//  TodoModule
//
//  Created by Afsarunnisa on 12/16/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import UIKit

public class TodoFramework {
    public static func performSegueTodoModule(caller: UIViewController) {
//        let podBundle = Bundle(for: TodoFramework.self)
//        let bundleURL = podBundle.url(forResource: "TodoModule", withExtension: "bundle")
//        let bundle = Bundle(url: bundleURL!)!
        let storyboard = UIStoryboard(name: "TodoModule", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        caller.present(vc, animated: true, completion: nil)
  
    }
}
