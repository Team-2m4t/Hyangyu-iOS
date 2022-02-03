//
//  Contact+CoreDataProperties.swift
//  
//
//  Created by 길태연 on 2022/02/02.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var title: String?
    @NSManaged public var review: String?
    @NSManaged public var data: String?
    @NSManaged public var scope: Double

}
