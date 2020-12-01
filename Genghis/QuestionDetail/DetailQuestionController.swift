//
//  DetailQuestionController.swift
//  Genghis
//
//  Created by Liana Haque on 11/20/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import Foundation

class DetailQuestionController {
    
    public init(view: DetailQuestionVC) {
        self.view = view
    }
    
    let view : DetailQuestionVC
    
    let questionRepository = QuestionRepository()
    
    public var questionListener: QuestionUpdateListener? = nil
    
    func saveQuestion(title: String, answers: [String], question: Question?) {
        let saveDate = Date()
        let isOptionsEmpty = checkIfOptionsAreEmpty(answers: answers)
        
        if isOptionsEmpty {
            view.presentAlertForEmptyOptions()
            return
        }
        
        let answerList = removeEmptyOptions(answers: answers)
        var questionToSave: Question? = nil
        
        if question != nil {
            //editing existing question route
            questionToSave = question
            questionToSave?.title = title
            questionToSave?.options = answerList
            questionToSave?.lastUpdated = saveDate
        }
        else {
            //new question route
            let generatedID = UUID()
            questionToSave = Question(id: generatedID, title: title, lastUpdated: saveDate, options: answerList)
        }
        questionListener?.onQuestionUpdate(question: questionToSave!)
        questionRepository.saveAsync(question: questionToSave!)
    }
    
    func removeEmptyOptions(answers: [String]) -> [String] {
        return answers.filter { !$0.isEmpty }
    }
    
    func checkIfOptionsAreEmpty(answers: [String]) -> Bool {
        if answers.isEmpty {
            return true
        }
        else {
            for index in 0...(answers.count - 1) {
                if !answers[index].isEmpty {
                    return false
                }
            }
        }
        return true
    }
}
