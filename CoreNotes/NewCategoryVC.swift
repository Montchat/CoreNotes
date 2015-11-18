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
    
    @IBOutlet weak var categoryNameField: UITextField! { didSet { categoryNameField.delegate = self } }
    
    @IBAction func didPickDate(sender: AnyObject) {
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        categoryNameField.text = ""
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func create(sender: AnyObject) {
        createCategory()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func viewDidLoad() {
     
    }
    
}