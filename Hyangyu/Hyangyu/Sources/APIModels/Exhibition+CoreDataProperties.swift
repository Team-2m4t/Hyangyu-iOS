//
//  Exhibition+CoreDataProperties.swift
//  
//
//  Created by 길태연 on 2022/02/02.
//
//

import Foundation
import CoreData


extension Exhibition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exhibition> {
        return NSFetchRequest<Exhibition>(entityName: "Exhibition")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var data: String?
    @NSManaged public var scope: Double

}
