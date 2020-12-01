//
//  QuestionController.swift
//  Genghis
//
//  Created by Liana Haque on 11/18/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import Foundation

/// Retains data focused, non-UI

class QuestionController: QuestionRepositoryResultListener {
    func onSaveSuccess() {
        return
    }
    
    func onDeleteSuccess() {
        
    }
    
    func onFetchAllSuccess(questions: [Question]) {
        view.updateView(questions: questions)
    }
    
    // TODO: Create AlertVC soon.
    func onFailure(error: NSError) {
        print("Error with Async Failure")
    }
    
    
    let questionRepository = QuestionRepository()
    let view : QuestionsVC

    public init(view: QuestionsVC) {
        self.view = view
    }
    
    func loadQuestions()  {
         questionRepository.fetchAllAsync(listener: self)  // because you instantiated above
    }
    
    func deleteQuestion(question: Question) {
        questionRepository.deleteAsync(listener: self, question: question)
    }
}

/*
 we make the listener here to keep the view from having too much logic.
 
 the controller is the listener to keep logic and so it can isolate and keep that code outside of the view.
 
 it will be the listener for many things.
 

 */
