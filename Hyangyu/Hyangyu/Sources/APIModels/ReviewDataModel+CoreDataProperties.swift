//
//  ReviewDataModel+CoreDataProperties.swift
//  
//
//  Created by 길태연 on 2022/01/30.
//
//

import Foundation
import CoreData


extension ReviewDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReviewDataModel> {
        return NSFetchRequest<ReviewDataModel>(entityName: "ReviewDataModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var review: String?
    @NSManaged public var data: String?
    @NSManaged public var scope: Double

}
