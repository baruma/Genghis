//
//  DetailQuestionVC.swift
//  Genghis
//
//  Created by Liana Haque on 10/1/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit
import CoreData

class DetailQuestionVC: UIViewController {

    let questionRepository = QuestionRepository()
    var tableView : UITableView!
    let titleTextField = TitleTextField()
    var optionTextField = OptionTextField()

    var questionTitle : String?
    var answers : [String] = []
    let cellText = ""
    
    let testID = UUID(uuidString: "3F977CA4-A0EA-44DB-B983-99144388FD85")

    /*
     3F947CA4-A0EA-44DB-B983-99144388FD85
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        let testID = UUID(uuidString: "3F977CA4-A0EA-44DB-B983-99144388FD85")

        // after a quick test the itd is empty
       // var test = Question(id: testID, title: "Test Title", lastUpdated: date, options: [String]())
        let result = questionRepository.fetchByID(id: testID!)
            
        configureTitleTextField()
        configureTableView()
        configureTitleTextFieldConstraints()
        configureTableViewAutoLayoutConstraint()


        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
        answers.append("qeqrqjlwkerjwlkuimxmx")
        answers.append("dfjgkljerioteiortieru")
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func addOptionButtonTapped() {
        print("Hit")
        answers.append("")
        tableView.reloadData()
    }
    
    @objc func saveButtonTapped() {
        print("Hit")
        // add UITableViewCell here with each hit
    }

    func configureTitleTextField() {
        view.addSubview(titleTextField)
        titleTextField.text = "Only Genghis can solve this"
        titleTextField.backgroundColor = .systemPink
        titleTextField.textColor = .white
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        self.tableView.register(OptionCell.self, forCellReuseIdentifier: OptionCell.reuseID)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureTableViewAutoLayoutConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureTitleTextFieldConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            titleTextField.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 3)
        ])
    }

}

extension DetailQuestionVC: UITableViewDelegate {}

extension DetailQuestionVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reuseID, for: indexPath) as! OptionCell
        cell.optionTextField.text = answers[indexPath.item]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            //questionRepository.delete(questionArg: Question(id: <#T##UUID#>, title: <#T##String#>, lastUpdated: <#T##Date#>, options: <#T##[String]#>))
         }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       let footerView           = UIView()
       let stackView            = UIStackView()
       let addOptionButton      = UIButton()
       let decisionButton       = UIButton()
       let cellHeight : CGFloat = 45
       let padding : CGFloat = 20
       let widthOfScreen = self.view.frame.width
        
       //footerView.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.1568627451, blue: 0, alpha: 1)  use this for testing
       footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
       footerView.addSubview(stackView)
        
       stackView.translatesAutoresizingMaskIntoConstraints  = false
       stackView.axis                                       = NSLayoutConstraint.Axis.vertical
       stackView.distribution                               = UIStackView.Distribution.equalSpacing
       stackView.alignment                                  = UIStackView.Alignment.center
       stackView.spacing                                    = 8.0
         
       addOptionButton.translatesAutoresizingMaskIntoConstraints    = false
       addOptionButton.layer.cornerRadius                           = 10
       addOptionButton.setTitle("Add Option", for: .normal)
       addOptionButton.backgroundColor                              = #colorLiteral(red: 0.9403936267, green: 0.7694521546, blue: 0.6657882333, alpha: 1)
        
       decisionButton.translatesAutoresizingMaskIntoConstraints     = false
       decisionButton.layer.cornerRadius                            = 10
       decisionButton.setTitle("INDECISION WILL BE THE END OF YOU", for: .normal)
       decisionButton.backgroundColor                               = #colorLiteral(red: 0.7960784314, green: 0.2470588235, blue: 0.1647058824, alpha: 1)
        
       stackView.addArrangedSubview(addOptionButton)
       stackView.addArrangedSubview(decisionButton)
        
        NSLayoutConstraint.activate([
            
            addOptionButton.heightAnchor.constraint(equalToConstant: cellHeight),
            addOptionButton.widthAnchor.constraint(equalToConstant: widthOfScreen - padding),

            decisionButton.heightAnchor.constraint(equalToConstant: cellHeight),
            decisionButton.widthAnchor.constraint(equalToConstant: widthOfScreen - padding),
        ])
        
       addOptionButton.addTarget(self, action: #selector(self.addOptionButtonTapped), for: [.touchUpInside, .touchUpOutside])
        
       stackView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true

       return footerView
    }
    
    
}


/*
 So what do we have to do now.
 
 [] 1.  Figure out how to write up answer options.
 [] 1.1 Tidying up the UI here.
 
 [] 2.  Turning the Question into a QuestionEntity
 
 [x] 3.  Fix up stackview
 
 [x] 4.  Fix up header view to take up a third of the screen or a half
 
 [] 5.   Keep stackview from disappearing from view.  Give it some clearancee via padding
 [] 5.1  Keep stack view planted on bottom of screen.  Only move it as the tableview grows past the screen.  Figure out a way to give it some clearance so it never goes past the tabbar.
 
 [] 6.   There is a decent chance you are going to have to swap out all the textfields for textviews.  Get ready to possibly use git.
 [] 6.1  Delete misc. code comments from here before saving first commit to Github.
 
 [] 7.   Place a hardcoded limit on how many options the user can add.  In 1.1 let them add in more options and figure out the footer issue then.
 
 
 That's something to think about.  You need the Decide Button to do a few things
 
    1. You need it to decide when the user adds in a question
    2. You need then, to ask if they'd like to save the Question for later.
 
 
 Every time you hit add options it should append an empty array
 
 
 */
