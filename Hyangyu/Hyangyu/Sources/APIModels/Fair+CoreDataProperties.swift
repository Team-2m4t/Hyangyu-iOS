//
//  Fair+CoreDataProperties.swift
//  
//
//  Created by 길태연 on 2022/02/02.
//
//

import Foundation
import CoreData


extension Fair {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fair> {
        return NSFetchRequest<Fair>(entityName: "Fair")
    }


}
