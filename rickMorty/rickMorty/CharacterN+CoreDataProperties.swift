//
//  CharacterN+CoreDataProperties.swift
//  rickMorty
//
//  Created by Александр Троицкий on 10.07.2023.
//
//

import Foundation
import CoreData
import UIKit

public extension CharacterN {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterN> {
        return NSFetchRequest<CharacterN>(entityName: "CharacterN")
    }

    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var sex: String?

}

extension CharacterN : Identifiable {}
