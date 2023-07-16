//
//  RickChar+CoreDataProperties.swift
//  rickMorty
//
//  Created by Александр Троицкий on 10.07.2023.
//
//

import Foundation
import CoreData
import UIKit


extension RickChar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RickChar> {
        return NSFetchRequest<RickChar>(entityName: "RickChar")
    }

    @NSManaged public var sex: String?
    @NSManaged public var species: String?
    @NSManaged public var name: String?

}

extension RickChar : Identifiable {

}
