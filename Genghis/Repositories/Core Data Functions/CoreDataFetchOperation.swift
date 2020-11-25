//
//  CoreDataFetchOperation.swift
//  Genghis
//
//  Created by Liana Haque on 11/23/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataFetchOperationDelegate {
    func operation(operation: CoreDataFetchOperation, didCompleteWithResult: [String: AnyObject])
}

class CoreDataFetchOperation: Operation {

    let delegate: CoreDataFetchOperationDelegate
    let privateManagedObjectContext: NSManagedObjectContext

    var identifier = 0
    var result = [String: AnyObject]()

    // MARK: - Initialization

    init(delegate: CoreDataFetchOperationDelegate, managedObjectContext: NSManagedObjectContext) {
        // Set Delegate
        self.delegate = delegate

        // Initialize Managed Object Context
        privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

        // Configure Managed Object Context
        privateManagedObjectContext.persistentStoreCoordinator = managedObjectContext.persistentStoreCoordinator

        super.init()
    }

    // MARK: - Perform Fetch Request

    func performFetchRequest() {}

    // MARK: - Overrides

    override func main() {
        performFetchRequest()

        DispatchQueue.main.async {
            // Notify Delegate
            self.delegate.operation(operation: self, didCompleteWithResult: self.result)
        }
    }

}
