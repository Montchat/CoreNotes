//
//  CoreData.swift
//  CoreNotes
//
//  Created by Joe E. on 11/17/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import CoreData

private let NAME = "name"
private let TEXT = "text"
private let CATEGORY = "Category"
private let _CATEGORY = "category"
private let NOTE = "Note"
private let REUSE_IDENTIFIER = "NoteCell"
private let _NOTES = "notes"
private let _TEXT = "text"

extension NSManagedObject {
    class func delegateAndEntity(name: String) -> (NSManagedObjectContext, NSEntityDescription)? {
        guard let _appDelegate = _appDelegate else { return nil }
        guard let entity = NSEntityDescription.entityForName(name, inManagedObjectContext: _appDelegate.managedObjectContext) else { return nil }
        
        return (_appDelegate.managedObjectContext,entity)
        
    }
    
}

class Category : NSManagedObject {
    class func category() -> Category? {
        guard let (moc,entity) = delegateAndEntity(CATEGORY) else { return nil }
        
        return Category.init(entity: entity,insertIntoManagedObjectContext: moc)
        
    }
    
    var name: String? {
        get { return valueForKey(NAME) as? String }
        set { setValue(newValue, forKey: NAME) }
        
    }
    
}

class Note: NSManagedObject {
    class func note() -> Note? {
        guard let (moc, entity) = delegateAndEntity(NOTE) else { return nil }
        return Note.init(entity: entity, insertIntoManagedObjectContext: moc)
        
    }
    
    var text: String? {
        get { return valueForKey(TEXT) as? String }
        set { setValue(newValue, forKey: TEXT) }
        
    }
    
    var category: NSManagedObject? {
        get { return valueForKey(CATEGORY) as? NSManagedObject }
        set { setValue(newValue, forKey: CATEGORY) }
    }
    
}

struct CategoryDictionary {
    var category : Category!
    var notes: [Note] = []
    
}

private let _appDelegate = { return UIApplication.sharedApplication().delegate as? AppDelegate }()

private typealias boom = Int

extension NotesTVC: Fetchable  {
    func fetchCategoriesAndNotes() {
        categories = []
        
        fetchEntity(CATEGORY, predicates: nil) { (found) -> () in
            
            guard let categories = found as? [Category] else { return }
            
            for category in categories {
                var newCategoryD = CategoryDictionary()
                newCategoryD.category = category
                
                let predicate = NSPredicate(format: "category == %@", category)
                
                self.fetchEntity(NOTE, predicates: [predicate], completion: { (found) -> () in
                    newCategoryD.notes = found as? [Note] ?? []
                    
                })
                
                self.categories.append(newCategoryD)
                print(self.categories)
                self.tableView.reloadData()
                
            }
            
        }
    
    }
    
}

extension NewNoteVC: Fetchable {
    
    func fetchCategories() {
        fetchEntity(CATEGORY, predicates: nil) { (found) -> () in
            print(found)
            self.categories = found as? [Category] ?? []
            self.categoryPicker.reloadAllComponents()
            
        }
        
    }
    
    func createNote() {
        let newNote = Note.note()
        newNote?.text = noteTextView.text
        
        newNote?.category = categories[categoryPicker.selectedRowInComponent(0)]
        
        _appDelegate?.saveContext()
        
    }
    
}

extension NewCategoryVC {
    func createCategory() {
        let newCategory = Category.category()
        newCategory?.setValue(categoryNameField.text, forKey: NAME)
        
        _appDelegate?.saveContext()
        
    }
    
}

protocol Fetchable {
    func fetchEntity(name: String, predicates: [NSPredicate]?, completion: (found: [AnyObject]) -> ())
    
}

extension Fetchable {
    func fetchEntity(name: String, predicates: [NSPredicate]?, completion: (found: [AnyObject]) -> ()) {
        let request = NSFetchRequest(entityName: name)
        guard let foundObjects = try? _appDelegate?.managedObjectContext.executeFetchRequest(request) ?? [] else { return  completion (found: []) }
        completion(found: foundObjects)
        
    }

}