//
//  Festival+CoreDataProperties.swift
//  
//
//  Created by 길태연 on 2022/02/02.
//
//

import Foundation
import CoreData


extension Festival {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Festival> {
        return NSFetchRequest<Festival>(entityName: "Festival")
    }


}
