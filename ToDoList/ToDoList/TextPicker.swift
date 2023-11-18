//
//  TextPicker.swift
//  ToDoList
//
//  Created by Эля Корельская on 27.10.2023.
//

import UIKit

class TextPicker {
    
    func showText(in viewcontroller: UIViewController, 
                  completion: @escaping ((String)->Void)){
        
        let alertController = UIAlertController(title: "ToDoList", message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        
        let actionOk = UIAlertAction(title: "OK", style: .default) {
            _ in
            /// если текст есть, то добавляем его в список
            if let text = alertController.textFields?[0].text, text != "" {
                completion(text)
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(actionOk)
        alertController.addAction(actionCancel)
        
        viewcontroller.present(alertController, animated: true)
    }
}


