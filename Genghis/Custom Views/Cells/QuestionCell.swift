//
//  QuestionCell.swift
//  Genghis
//
//  Created by Liana Haque on 9/28/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    static let reuseID = "QuestionCell"
    
    let questionLabel = GenBodyLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        questionLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(questionLabel)
        backgroundColor                             = .systemBackground
        translatesAutoresizingMaskIntoConstraints   = false
        let padding: CGFloat                        = 20

        NSLayoutConstraint.activate([
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            questionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
        ])
    }

}
