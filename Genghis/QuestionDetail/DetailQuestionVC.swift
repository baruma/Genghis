//
//  DetailQuestionVC.swift
//  Genghis
//
//  Created by Liana Haque on 10/1/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit
import CoreData

// keeps track of all listeners the ptotocal you declared
class DetailQuestionVC: UIViewController, OptionTextChangeListener {
    
    private var controller : DetailQuestionController!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        controller = DetailQuestionController(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var question : Question? = nil
    var answers : [String] = []

    var tableView : UITableView!
    let titleTextView = TitleTextView(frame: .zero)
    var optionTextField = OptionTextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTitleTextView()
        configureTableView()
        configureTitleTextViewConstraints()
        configureTableViewAutoLayoutConstraint()
        configureActionButtonStackView()

        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        determineCreateOrUpdateQuestion()

        addBlankOptions()
        tableView.reloadData()
    }
    
    public func setQuestionUpdateListener(listener: QuestionUpdateListener) {
        controller.questionListener = listener
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func addOptionButtonTapped() {
        answers.append("")
        tableView.reloadData()
    }
    
    @objc func decisionButtontapped() {
        let randomDecision = answers.randomElement()
        let alert = UIAlertController(title: randomDecision, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Neat", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func saveButtonTapped() {
        controller.saveQuestion(title: titleTextView.text, answers: answers, question: question)
        navigationController?.popViewController(animated: true)
    }
    
    
    func presentAlertForEmptyOptions() {
        let alert = UIAlertController(title: "You haven't entered any options!", message: "Pretty please fill out some options :)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okie Dokie", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func onTextChange(row: Int, text: String) {
        answers[row] = text
    }

    func determineCreateOrUpdateQuestion() {
        if question != nil {
            titleTextView.text = question?.title
            answers = question?.options as! [String]
            print(question)
        }
        else {
            return 
        }
    }
    
    func createAlert(decision: String) {  // rename this
        let alert = UIAlertController(title: "This is a title", message: nil , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Neat!", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    
    func addBlankOptions() {
        if question != nil{}
        else {
            answers.append("")
            answers.append("")
        }
    }
    
    func configureTitleTextView() {
        view.addSubview(titleTextView)
        titleTextView.text = "Only Genghis can solve this"
        titleTextView.backgroundColor = .systemPink
        //titleTextView.backgroundColor = UIColor(red: 244, green: 67, blue: 54, alpha: 1)
        titleTextView.textColor = .white
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        self.tableView.register(OptionCell.self, forCellReuseIdentifier: OptionCell.reuseID)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureTableViewAutoLayoutConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureTitleTextViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: view.topAnchor),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            titleTextView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 3)
        ])
    }
    
    func configureActionButtonStackView() {
        let stackView            = UIStackView()
        let addOptionButton      = UIButton()
        let decisionButton       = UIButton()
        let padding : CGFloat    = 60
        let widthOfScreen        = self.view.frame.width
        
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints  = false
        stackView.axis                                       = NSLayoutConstraint.Axis.vertical
        stackView.distribution                               = UIStackView.Distribution.equalSpacing
        stackView.alignment                                  = UIStackView.Alignment.center
        stackView.spacing                                    = 8.0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)

        addOptionButton.translatesAutoresizingMaskIntoConstraints    = false
        addOptionButton.layer.cornerRadius                           = 10
        addOptionButton.titleLabel?.font                             = UIFont.boldSystemFont(ofSize: 18)
        addOptionButton.setTitle("Add Option", for: .normal)
        addOptionButton.backgroundColor                              = .systemBlue

        decisionButton.translatesAutoresizingMaskIntoConstraints     = false
        decisionButton.layer.cornerRadius                            = 10
        decisionButton.titleLabel?.font                              = UIFont.boldSystemFont(ofSize: 18)
        decisionButton.setTitle("Indecision will be the end of you!", for: .normal)
        decisionButton.backgroundColor                               = .systemRed
         
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.addArrangedSubview(addOptionButton)
        stackView.addArrangedSubview(decisionButton)
    
         NSLayoutConstraint.activate([
             stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
             
             addOptionButton.heightAnchor.constraint(equalToConstant: 50),
             addOptionButton.widthAnchor.constraint(equalToConstant: widthOfScreen - padding),

             decisionButton.heightAnchor.constraint(equalToConstant: 50),
             decisionButton.widthAnchor.constraint(equalToConstant: widthOfScreen - padding),
         ])
         
        addOptionButton.addTarget(self, action: #selector(self.addOptionButtonTapped), for: [.touchUpInside, .touchUpOutside])
        decisionButton.addTarget(self, action: #selector(self.decisionButtontapped), for: [.touchUpInside, .touchUpOutside])
    }
}

extension DetailQuestionVC: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension DetailQuestionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reuseID, for: indexPath) as! OptionCell
        cell.optionTextView.text = answers[indexPath.item]
        cell.rowIndex = indexPath.item
        cell.setTextChangeListener(listener: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.answers.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
         }
    }
}

/*
 keep the queestion listener and the navigation code and move everything else into the controller
 
 have controller keep question listener
 */
