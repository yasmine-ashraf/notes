//
//  TableViewFuncs.swift
//  Note
//
//  Created by Yasmine Ashraf on 30/08/2021.
//

import UIKit
extension NotesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        let title = notesArray[indexPath.row].noteTitle
        let subtitle = notesArray[indexPath.row].noteDetails
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        isNew = false
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier{
            if id == "innerSegue"{
                let newVC = segue.destination as! InnerViewController
                newVC.innerViewControllerDelegate = self
                if let cell = sender as? UITableViewCell {
                    if isNew == false {
                        latestIndex = self.tableView.indexPath(for: cell)?.row
                        if let latestIndex = self.latestIndex, latestIndex >= 0, latestIndex < notesArray.count {
                            newVC.passedTitle = notesArray[latestIndex].noteTitle!
                            newVC.passedDetails = notesArray[latestIndex].noteDetails!
                            if let loc = notesArray[latestIndex].noteLocation{
                                newVC.thisAddress = loc
                                if let date = notesArray[latestIndex].noteDate{
                                    newVC.thisDate = date
                                }
                            }
                        }else {
                            print("error preparing for segue")
                        }
                    }
                }
            }
        }
    }
}
