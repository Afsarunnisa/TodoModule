//
//  TodoModuleUtilities.swift
//  TodoSampleApp
//
//  Created by Afsarunnisa on 12/15/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import UIKit


public class TodoModuleUtilities {
    
    class func alertView(_ alertTitle: String, alertMsg:String, actionTitle: String) -> UIAlertController{
        let alert = UIAlertController(title:alertTitle, message:alertMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:actionTitle, style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
    
    
    public class func loadBundle() -> Bundle{
        return Bundle(for: self)
    }
}
