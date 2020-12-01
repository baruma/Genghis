//
//  QuestionRepository.swift
//  Genghis
//
//  Created by Liana Haque on 10/24/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit
import CoreData
import Foundation

protocol QuestionRepositoryResultListener {
    /// Data Type Success Functions
    func onFetchAllSuccess(questions: [Question])
    func onSaveSuccess()
    func onDeleteSuccess()
    
    /// On Failure Function - Applicable to all CRUD scenarios
    func onFailure(error: NSError)
}

class QuestionRepository {
    
    // lazy means it's not initialized till the first time it is called
    
    lazy var context: NSManagedObjectContext = { return persistentContainer.newBackgroundContext()}()
    // anytime you want to do something async.
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Genghis")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    /// This is thread agnostic as it takes in a thread
    func save(question: Question, context: NSManagedObjectContext) {
//        let managedContext = persistentContainer.viewContext
        let questionEntity = NSEntityDescription.entity(forEntityName: "QuestionEntity", in: context)!
      
        var questionToSave: NSManagedObject? = nil
        questionToSave = fetchEntityByID(id: question.id, context: context)
        if(questionToSave == nil) {
            questionToSave = NSManagedObject(entity: questionEntity, insertInto: context)
        }
        
        let jsonString = convertStringArrayToJSON(optionString: question.options)
        questionToSave?.setValue(question.id, forKey: "id")
        questionToSave?.setValue(question.title, forKeyPath: "title")
        questionToSave?.setValue(question.lastUpdated, forKey: "lastUpdated")
        questionToSave?.setValue(jsonString, forKey: "options")
        do {
          try context.save()
          print("Core Data Save Succeess")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    /// This defines the background thread
    func saveAsync(question: Question) {
        persistentContainer.performBackgroundTask { (context) in
            self.save(question: question, context: context)
        }
    }
    
//     keep for now
//    func fetchByID(id: UUID, context: NSManagedObjectContext) -> Question? {
//        let questionResult = fetchEntityByID(id: id, context: context)
//        if (questionResult == nil) {
//            return nil
//        } else {
//            return mapToDataModel(entity: questionResult!)
//        }
//    }
    
    /// This is thread agnostic because we pass in the context.  The context is aware of what thread this is on.
    
    private func fetchEntityByID(id: UUID, context: NSManagedObjectContext) -> QuestionEntity? {
            let questionFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionEntity")
            
            questionFetch.predicate = NSPredicate(format: "id == %@", argumentArray: [id.uuidString])
            
            do {
                let questionEntities = try context.fetch(questionFetch) as! [QuestionEntity]
                print("FetchbyID is successful")
                // Error check to ensure something is in the array.  This is an edge case to look out for.
                if questionEntities.count == 0 {
                    print("Yep I'm Hit")
                    // For the future write a UIAlert
                    return nil
                }
                else {
                    return questionEntities[0]
                }
            } catch {
                print("FetchbyID failed")
            }
            return nil
    }
    
    func fetchAllAsync(listener: QuestionRepositoryResultListener) {
        persistentContainer.performBackgroundTask { (context) in
            do {
                var questions = [NSManagedObject]()
                var mappedResult = [Question]()
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "QuestionEntity")
                questions = try context.fetch(fetchRequest)
                
                for q in questions {
                    let mappedQuestion = self.mapToDataModel(entity: q as! QuestionEntity)
                    mappedResult.append(mappedQuestion)
                    print(mappedQuestion.id.uuidString)
                }
                DispatchQueue.main.async {
                    listener.onFetchAllSuccess(questions: mappedResult)
                }
            }
            catch let error as NSError {
                print("Could not fetch. \(error)")
                DispatchQueue.main.async {
                    listener.onFailure(error: error)
                }
            }
        }
    }
    
    func deleteAsync(listener: QuestionRepositoryResultListener, question: Question) {
        persistentContainer.performBackgroundTask { (context) in
            do {
                var question = self.fetchEntityByID(id: question.id, context: context)
                print("Deleting question " + question!.id!.uuidString)
                if (question != nil) {
                    context.delete(question!)
                    do {
                      try context.save()
                      print("Core Data Save after Delete Succeess")
                    }
                }
            }
            catch let error as NSError{
                print("Could not save. \(error)")
                DispatchQueue.main.async {
                    // listener type response here.
                }
            }
        }
    }
    
    func mapToDataModel(entity: QuestionEntity) -> Question {
        let optionsArray = convertJSONToStringArray(jsonString: entity.options!)  // handle the optional stuff properly
        return Question(id: entity.id!, title: entity.title!, lastUpdated: entity.lastUpdated!, options: optionsArray)
    }
    
    func convertStringArrayToJSON(optionString: [String]) -> String {
        let errorMessage = "JSON Conversion didn't quite work."
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: optionString, options: [])
            if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                print(jsonString)
                return jsonString as String
            }
        }
        catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
        return errorMessage
    }
    
    func convertJSONToStringArray(jsonString: String) -> [String] {
        let data = jsonString.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String]
            {
               print(jsonArray)
               return jsonArray
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        return [String]()
    }
}



/*
 
 Seperate CoreData from AppDelegate
 
 
 The only thing we're changing is how we're getting managedContext.  It used to be in a container in AppDelegate but we moved it here.  We're getting the managedcontext the same way we're just not talking to the app delegate.
 
 We do this because there's no reason to talk to the App Delegate.
 
 command i to autoformat
 
 
 1. create lazy nsmanagedobject context object that returns persistentcontainer.newbackgroundcontext ... we're combinging context
 
 persistentContainer.performBackgroundTask { (context) in
      // do stuff
  }
 
 when you delete or update you need to call save

 
 listener should have success failure case and that's it
 
 what's the difference between manager and repository - repository is more specific because ti works with data and crud options, whereas a manager can delegate work retrive data and do many many many more things.  repository expectations are that you work with data.
 */
