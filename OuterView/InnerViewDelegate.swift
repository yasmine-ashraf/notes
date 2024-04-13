//
//  InnerViewDelegate.swift
//  Note
//
//  Created by Yasmine Ashraf on 30/08/2021.
//

import Foundation

extension NotesTableViewController: InnerViewControllerDelegate{
    //Recieving note details from the inner view by protocol
    func passNote(_ finalTitle: String, _ finalDetails: String, _ loc:String, _ date:String) {
        if isNew == false{
            if let latestIndex = self.latestIndex, latestIndex >= 0, latestIndex < notesArray.count{
                updateItem(noteTitle: finalTitle, noteDetails: finalDetails)
            }
        } else {
            createItem(noteTitle: finalTitle, noteDetails: finalDetails, noteLocation: loc, noteDate: date)
        }
        tableView.reloadData()
    }
    func deleteNote() {
        if isNew{return}
        if let latestIndex = self.latestIndex, latestIndex >= 0, latestIndex < notesArray.count{
            let item = notesArray[latestIndex]
            deleteItem(item: item)
            getAllNotes()
        }
    }
}

