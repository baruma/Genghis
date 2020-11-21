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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let questionEntity = NSEntityDescription.entity(forEntityName: "QuestionEntity", in: managedContext)!
      
        var questionToSave: NSManagedObject? = nil
        questionToSave = fetchEntityByID(id: questionArg.id)
        if(questionToSave == nil) {
            questionToSave = NSManagedObject(entity: questionEntity, insertInto: managedContext)
        }
        
        let jsonString = convertStringArrayToJSON(optionString: questionArg.options)
        questionToSave?.setValue(questionArg.id, forKey: "id")
        questionToSave?.setValue(questionArg.title, forKeyPath: "title")
        questionToSave?.setValue(questionArg.lastUpdated, forKey: "lastUpdated")
        questionToSave?.setValue(jsonString, forKey: "options")
        do {
          try managedContext.save()
          print("Core Data Save Succeess")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchByID(id: UUID) -> Question? {
        let questionResult = fetchEntityByID(id: id)
        if(questionResult == nil) {
            return nil
        } else {
            return mapToDataModel(entity: questionResult!)
        }
    }
    
    private func fetchEntityByID(id: UUID) -> QuestionEntity? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
            let managedContext = appDelegate.persistentContainer.viewContext
            let questionFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionEntity")
            
            questionFetch.predicate = NSPredicate(format: "id == %@", argumentArray: [id.uuidString])
            
            do {
                let questionEntities = try managedContext.fetch(questionFetch) as! [QuestionEntity]
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
                print(mappedQuestion.id.uuidString)
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

        var question = fetchEntityByID(id: questionArg.id)
        print("Deleting question " + question!.id!.uuidString)
        if (question != nil) {
            managedContext.delete(question!)
            do {
              try managedContext.save()
              print("Core Data Save after Delete Succeess")
            } catch let error {
              print("Could not save after delete)")
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


