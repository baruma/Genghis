//
//  DecisionsVC.swift
//  Genghis
//
//  Created by Liana Haque on 9/26/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

/// This VIew Controller is assigned for the first screen of the app.
/// it is responsible for displaying the user's questions, and creating a segue to the DetailQuestionController where the user can create new questions.

import UIKit
import CoreData

/// The listener is asking the QuestionVC to listen for whether a new or old Question object is being either created or edited (respectively).  listener
protocol QuestionUpdateListener {
    func onQuestionUpdate (question: Question)
}

// The QuestionsVC is responsible for listening out for the Question object in order to notify the protocol of what is going on.
class QuestionsVC: UIViewController, QuestionUpdateListener {

    var tableView: UITableView!
    //let searchController = UISearchController(searchResultsController: nil)
    let createQuestionButton = GenActionButton(backgroundColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), title: "Let Genghis Decide!")

    var questions: [Question] = [Question]()
    let controller = QuestionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions = controller.loadQuestions()
        //navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        configureTableView()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // self.tabBarController?.tabBar.isHidden = true
    }
    
    func onQuestionUpdate (question: Question) {
        var hasBeenFound = isExistingQuestion(question: question)
        if !hasBeenFound {
            questions.append(question)
        }
        tableView.reloadData()
    }
    
    func isExistingQuestion(question: Question) -> Bool {
        var hasBeenFound = false
        
        if questions.count > 0 {
            for index in 0...(questions.count - 1) {
                if questions[index].id == question.id
                {
                    questions[index] = question
                    hasBeenFound = true
                    break
                }
            }
        }
        return hasBeenFound
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        configureCreateActionButton()
        tableView.register(QuestionCell.self, forCellReuseIdentifier: QuestionCell.reuseID)
        tableView.separatorStyle = .none
    }
    
    func configureCreateActionButton() {
        tableView.addSubview(createQuestionButton)
        createQuestionButton.addTarget(self, action: #selector(pushDetailQuestionVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
             createQuestionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
             createQuestionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
             createQuestionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
             createQuestionButton.heightAnchor.constraint(equalToConstant: 50)
         ])
    }
    /// Performs segue to DetailQuestionVC .
    /// so we're wondering, where the heck is the setQuestionUpdateListener even declared.  Why does it take in an argument of listener.
     @objc func pushDetailQuestionVC() {
        let detailQuestionsVC = DetailQuestionVC()
        /// setQuestionUpdateListener is a public function declared here in order to set the listener to the segue.
        detailQuestionsVC.setQuestionUpdateListener(listener: self)
        navigationController?.pushViewController(detailQuestionsVC, animated: true)
    }
}

extension QuestionsVC: UITableViewDelegate {}

extension QuestionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.reuseID, for: indexPath) as! QuestionCell
        cell.questionLabel.text = questions[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuestion = questions[indexPath.row]
        let detailQuestionVC = DetailQuestionVC()
        detailQuestionVC.setQuestionUpdateListener(listener: self)
        detailQuestionVC.question = selectedQuestion  
        navigationController?.pushViewController(detailQuestionVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller.deleteQuestion(question: questions[indexPath.row])
            questions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
