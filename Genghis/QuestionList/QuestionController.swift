//
//  QuestionController.swift
//  Genghis
//
//  Created by Liana Haque on 11/18/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import Foundation

class QuestionController {
    
    let questionRepository = QuestionRepository()
    
    func loadQuestions() -> [Question] {
        return questionRepository.fetchAll()
    }
    
    func deleteQuestion(question: Question) {
        questionRepository.delete(questionArg: question)
    }
}
