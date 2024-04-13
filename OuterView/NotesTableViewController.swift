//
//  NotesTableViewController.swift
//  Note
//
//  Created by Yasmine Ashraf on 06/08/2021.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {
    var notesArray = [NoteItem]()
    var isNew = false
    var latestIndex:Int?
    var thisAddress = "mtghyrsh"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllNotes()
    }
    @IBAction func newNoteClicked(_ sender: UIBarButtonItem) {
        guard let controller = self.storyboard!.instantiateViewController(identifier: "inner") as? InnerViewController else {return}
        controller.innerViewControllerDelegate = self
        controller.isNew = true
        isNew = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
