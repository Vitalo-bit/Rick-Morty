//
//  RickProvider.swift
//  rickMorty
//
//  Created by Александр Троицкий on 10.07.2023.
//

import CoreData
import UIKit

class RickProvider {
    private(set) var managedObjectContext: NSManagedObjectContext
    private weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?

    init(with managedObjectContext: NSManagedObjectContext,
         fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?)
    {
        self.managedObjectContext = managedObjectContext
        self.fetchedResultsControllerDelegate = fetchedResultsControllerDelegate
    }

    lazy var fetchedResultsController: NSFetchedResultsController<RickChar> = {
        let fetchRequest: NSFetchRequest<RickChar> = NewsPosts.fetchRequest()

        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest, managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        controller.delegate = fetchedResultsControllerDelegate

        do {
            try controller.performFetch()
        } catch {
            print("Fetch failed")
        }

        return controller
    }()
}
