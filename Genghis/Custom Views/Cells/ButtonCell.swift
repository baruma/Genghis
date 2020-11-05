//
//  ButtonCell.swift
//  Genghis
//
//  Created by Liana Haque on 10/13/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    static let reuseID = "ButtonCell"
    
    let actionButton = GenActionButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    private func configure() {
        contentView.addSubview(actionButton)
        
        actionButton.backgroundColor                = .blue
        translatesAutoresizingMaskIntoConstraints   = false
        
        let padding: CGFloat = 0
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 100),
            actionButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

}

// How do you make this reusable so you don't have to create a new cell entirely?  Do you need to create a new cell entirely?
