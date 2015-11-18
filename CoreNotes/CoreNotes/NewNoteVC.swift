//
//  NewNoteVC.swift
//  CoreNotes
//
//  Created by Joe E. on 11/16/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import CoreData

private let CATEGORY = "Category"
private let _CATEGORY = "category"
private let NOTE = "Note"
private let _TEXT = "text"

class NewNoteVC: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    @IBAction func cancel(sender: AnyObject) {

        
    }
    
    @IBAction func create(sender: AnyObject) {
        createNote()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        categoryPicker.dataSource = self
        
    }
    
    var categories: [Category] = []

}

extension NewNoteVC : UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
}

extension NewNoteVC : UIPickerViewDataSource {
    
    
    
    
}