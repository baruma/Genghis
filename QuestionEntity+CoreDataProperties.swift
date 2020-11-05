//
//  Question+CoreDataProperties.swift
//  Genghis
//
//  Created by Liana Haque on 10/22/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//
//

import Foundation
import CoreData


extension QuestionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionEntity> {
        return NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var options: String?

}
