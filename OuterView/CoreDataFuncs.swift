//
//  CoreDataFuncs.swift
//  Note
//
//  Created by Yasmine Ashraf on 30/08/2021.
//

import UIKit

extension NotesTableViewController {
    func getAllNotes(){
        do{
            notesArray = try context.fetch(NoteItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            print("error getting notes")
        }
    }
    func createItem(noteTitle:String, noteDetails:String, noteLocation:String, noteDate:String){
        let newItem = NoteItem(context: context)
        newItem.noteTitle = noteTitle
        newItem.noteDetails = noteDetails
        newItem.noteLocation = noteLocation
        newItem.noteDate = noteDate
        notesArray.insert(newItem, at: 0)
        do{
            try context.save()
        }
        catch{
            print("error saving new item")
        }
    }
    func deleteItem(item:NoteItem){
        context.delete(item)
        do{
            try context.save()
        }
        catch{
            //error
        }
    }
    func updateItem(noteTitle:String, noteDetails:String){
        do{
            if let latestIndex = latestIndex, latestIndex < notesArray.count{
                let item = notesArray[latestIndex]
                item.noteTitle = noteTitle
                item.noteDetails = noteDetails
            }
            try context.save()
        } catch{
            print("error updating note")
        }
    }
    //end of Core Data functions
}
