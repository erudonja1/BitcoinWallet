//
//  UIService.swift
//  GitStats
//
//  Created by mac on 27/03/16.
//  Copyright © 2016 Elvis Studio. All rights reserved.
//

import UIKit

class AlertCenter{
    
    //Showing message alert with dynamic content
    class func show(title:String, message: String, buttonText: String, viewController: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func show(title:String, message: String, buttonText: String, viewController: UIViewController, completion: @escaping () -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: { action in
            completion()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func show(title:String, placeholder: String, buttonText: String, viewController: UIViewController, completion: @escaping (String) -> ()){
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            completion((textField?.text) ?? "")
            alert?.dismiss(animated: false, completion: nil)
        }))
        
        // 4. Present the alert.
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func question(title:String, buttonText: String, buttonText2: String, viewController: UIViewController, completion: @escaping (String) -> ()){
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: { action in
            completion(buttonText)
        }))
        alert.addAction(UIAlertAction(title: buttonText2, style: UIAlertActionStyle.default, handler: { action in
            completion(buttonText2)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { action in
            completion("Cancel")
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
}
