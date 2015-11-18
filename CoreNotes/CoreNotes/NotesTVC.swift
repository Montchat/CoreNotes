//
//  NotesTVC.swift
//  CoreNotes
//
//  Created by Joe E. on 11/16/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import CoreData

private let NOTES = "notes"
private let NOTE = "Note"
private let REUSE_IDENTIFIER = "NoteCell"
private let CATEGORY = "Category"
private let _CATEGORY = "category"
private let NAME = "name"

class NotesTVC: UITableViewController {
    var categories: [CategoryDictionary] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].notes.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(REUSE_IDENTIFIER, forIndexPath: indexPath)
        cell.textLabel?.text = NOTE

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            //remove note from CoreData

            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let label = UILabel(frame: view.frame)
        label.text = categories[section].category.name
        label.textColor = UIColor.whiteColor()
        
        view.addSubview(label)
        
        return view
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
        
    }
    
}
