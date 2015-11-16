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
private let REUSE_IDENTIFIER = "NoteCell"
private let CATEGORY = "Category"
private let _CATEGORY = "category"
private let NAME = "name"

class NotesTVC: UITableViewController {
    
    //[["name" : "category_name", "notes" : [NSManagedObject]]]
    
    var categories: [[String:AnyObject]] = []
        //array of categories
            //category dictionary
                //"category" : NSManagedObject,
                //"notes" : // notes array
                    //NSanagedObject
                    //NSManagedObject

//    var categories: [NSManagedObject] = []
//    var notes: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appD = UIApplication.sharedApplication().delegate as? AppDelegate else { return }
        
        let categoryRequest = NSFetchRequest(entityName: CATEGORY)
        let foundCategories = (try? appD.managedObjectContext.executeFetchRequest(categoryRequest) as? [NSManagedObject] ?? []) ?? []
        
        for category in foundCategories {
            let newCatDictionary = [
                _CATEGORY : category,
                NOTES : []
            
            ]
            
            categories.append(newCatDictionary)
            
        }
        
        tableView.reloadData()
        
        //make a fetch request to fill tableiew with notes where sections = categories

        
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
        
        let category = categories[section]
        let notes = category[NOTES] as? [AnyObject]
        
        return notes?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(REUSE_IDENTIFIER, forIndexPath: indexPath)

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
        
        let category = categories[section]
        let managedObject = category[_CATEGORY] as? NSManagedObject
        let name = managedObject?.valueForKey(NAME) as? String
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let label = UILabel(frame: view.frame)
        label.text = name
        label.textColor = UIColor.whiteColor()
        
        view.addSubview(label)
        
        return view
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
