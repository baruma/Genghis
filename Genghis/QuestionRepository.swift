//
//  QuestionRepository.swift
//  Genghis
//
//  Created by Liana Haque on 10/24/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit
import CoreData

class QuestionRepository {
    
    func save(questionArg: Question) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }  // Why do we need the app delegate

        let managedContext = appDelegate.persistentContainer.viewContext  // in-memory “scratchpad” for working with managed objects.  Put your entity in here.
        let questionEntity = NSEntityDescription.entity(forEntityName: "QuestionEntity", in: managedContext)!  // insert managedObject into managedObjectContext. This is the entity description
        let question = NSManagedObject(entity: questionEntity, insertInto: managedContext)  // represents a single object stored in Core Data; use it to create, edit, save and delete from CoreData

        question.setValue(questionArg.id, forKey: "id")
        question.setValue(questionArg.title, forKeyPath: "title")
        question.setValue(questionArg.lastUpdated, forKey: "lastUpdated")
        //question.setValue(questionArg.options, forKey: "options")
        
        do {
          try managedContext.save()
          print("SUCCEEEEEESSSSSSSSSSS")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    /*
     So for the save function.  So we are using these functions in the view controller in order to limit core data's access to the view layer.
     So that means we are passing around structs instead of the core data entities.
     
     So if we are planing this save function to take in a save object that means we are probably going to have to convert to coredata.
     */
    
    func fetchByID(id: UUID) -> Question? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        let questionFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionEntity")
        
        questionFetch.predicate = NSPredicate(format: "id == %@", argumentArray: [id.uuidString])
        
        do {
            var questionEntities = try managedContext.fetch(questionFetch) as! [QuestionEntity]
            print("FetchbyID is successful")
            // Error check to ensure something is in the array.  This is an edge case to look out for.
            if questionEntities.count == 0 {
                print("Yep I'm Hit")
                // For the future write a UIAlert 
                return nil
            }
            else {
                return mapToDataModel(entity: questionEntities[0])
            }
        } catch {
            print("FetchbyID failed")
        }
        
        return nil
    }
    
    func fetchAll() -> [Question] {
        var questions = [NSManagedObject]()
        var mappedResult = [Question]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return [Question]()  // returns empty list of questions
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "QuestionEntity")
        
        do {
            questions = try managedContext.fetch(fetchRequest)
            for q in questions {
               var mappedQuestion = mapToDataModel(entity: q as! QuestionEntity)
                mappedResult.append(mappedQuestion)
            }
            return mappedResult
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return [Question]()
    }
    
    func delete(questionArg: Question) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let questionEntity = NSEntityDescription.entity(forEntityName: "QuestionEntity", in: managedContext)!
        let question = NSManagedObject(entity: questionEntity, insertInto: managedContext)
        
        let questionEntityToDelete = mapToEntity(question: questionArg)
        
        managedContext.delete(questionEntityToDelete)
    }
    
    func mapToEntity(question: Question) -> QuestionEntity {
        var entity = QuestionEntity()
        entity.id = question.id
        entity.title = question.title
        entity.lastUpdated = question.lastUpdated
        entity.options = ""
        return entity
    }
    
    func mapToDataModel(entity: QuestionEntity) -> Question {
        return Question(id: entity.id!, title: entity.title!, lastUpdated: entity.lastUpdated!, options: [String]())
    }
}


/*
 Things to consider
 1. ID
 2. FetchAll // for the initial visit into the app
 3. Method for 1.1./1.2 Search Bar to parse for question
 4. Throw mapper functions into crud funcs
 
 saving an entirely new question vs update... consider saving by id or saving a new question
 
 */
