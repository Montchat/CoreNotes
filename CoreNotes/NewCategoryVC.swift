//
//  NewCategoryVC.swift
//  CoreNotes
//
//  Created by Joe E. on 11/16/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import CoreData

private let CATEGORY = "Category"
private let NAME = "name"

class NewCategoryVC: UIViewController {
    
    var pickedDate: NSDate = NSDate()
    
    @IBOutlet weak var categoryNameField: UITextField!
    
    @IBAction func didPickDate(sender: AnyObject) {
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        categoryNameField.text = ""
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func create(sender: AnyObject) {
        guard let appD = UIApplication.sharedApplication().delegate as? AppDelegate else { return }
        
        let newCategory = NSEntityDescription.insertNewObjectForEntityForName(CATEGORY, inManagedObjectContext: appD.managedObjectContext)
        newCategory.setValue(categoryNameField.text, forKey: NAME)
        
        appD.saveContext()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func viewDidLoad() {
        categoryNameField.delegate = self
    }
    
}

extension NewCategoryVC : UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}