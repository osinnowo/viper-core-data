//
//  User+CoreDataProperties.swift
//  ViperCoreData
//
//  Created by Osinnowo Emmanuel on 04/03/2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?

}

extension User : Identifiable {

}
