//
//  CoreDataFetchAll.swift
//  Genghis
//
//  Created by Liana Haque on 11/23/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

//import Foundation
//import CoreData
//
//protocol CoreDataFetchAllOperationDelegate {
//    func operation(operation: CoreDataFetchAll, didCompleteWithResult: [String: AnyObject])
//}
//
//class CoreDataFetchAll: Operation {
//    
//    let delegate: CoreDataFetchAllOperationDelegate
//    let privateManagedObjectContext: NSManagedObjectContext
//
//    var identifier = 0
//    var result = [String: AnyObject]()
//    
//    init(delegate: CoreDataFetchAllOperationDelegate, managedObjectContext: NSManagedObjectContext) {
//        // Set Delegate
//        self.delegate = delegate
//
//        // Initialize Managed Object Context
//        privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//
//        // Configure Managed Object Context
//        privateManagedObjectContext.persistentStoreCoordinator = managedObjectContext.persistentStoreCoordinator
//
//        super.init()
//    }
//
//    // MARK: - Perform Fetch Request
//
//    func performFetchRequest() {}
//
//    // MARK: - Overrides
//
//    override func main() {
//        performFetchRequest()
//
//        DispatchQueue.global(qos: .background).async {
//            // Notify Delegate
//            self.delegate.operation(operation: self, didCompleteWithResult: self.result)
//            
//            // Original Function
//            /*
//             dispatch_async(dispatch_get_main_queue()) {
//                 // Notify Delegate
//                 self.delegate.operation(self, didCompleteWithResult: self.result)
//             }
//             */
//        }
//    }
//}
