//
//  NoteItem+CoreDataProperties.swift
//  Note
//
//  Created by Yasmine Ashraf on 09/08/2021.
//
//

import Foundation
import CoreData

extension NoteItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteItem> {
        return NSFetchRequest<NoteItem>(entityName: "NoteItem")
            }
    @NSManaged public var noteTitle: String?
    @NSManaged public var noteDetails: String?
    @NSManaged public var noteLocation: String?
    @NSManaged public var noteDate: String?
}

extension NoteItem : Identifiable {

}
