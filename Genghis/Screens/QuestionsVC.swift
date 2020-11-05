//
//  DecisionsVC.swift
//  Genghis
//
//  Created by Liana Haque on 9/26/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit
import CoreData

class QuestionsVC: UIViewController {
    
    var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    let createQuestionButton = GenActionButton(backgroundColor: #colorLiteral(red: 0.7960784314, green: 0.2470588235, blue: 0.1647058824, alpha: 1), title: "Let Genghis Decide!")
    
    let stringone = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and nto electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    let stringtwo = "this is string two"
    let stringthree = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    var dataSource: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        configureTableView()

    }

    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        configureCreateActionButton()
        dataSource.append(stringone)
        dataSource.append(stringtwo)
        dataSource.append(stringthree)
        tableView.register(QuestionCell.self, forCellReuseIdentifier: QuestionCell.reuseID)
        
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
    
     @objc func pushDetailQuestionVC() {
        let detailQuestionsVC = DetailQuestionVC()
        navigationController?.pushViewController(detailQuestionsVC, animated: true)
    }
    
}

extension QuestionsVC: UITableViewDelegate {}

extension QuestionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.reuseID, for: indexPath) as! QuestionCell
        cell.questionLabel.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
