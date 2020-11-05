//
//  OptionCell.swift
//  Genghis
//
//  Created by Liana Haque on 10/2/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {
    
    static let reuseID = "OptionCell"
    
    let optionTextField = OptionTextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(optionTextField)
        
        optionTextField.text                        = "This text is neat"
        optionTextField.textColor                   = .systemGray
        translatesAutoresizingMaskIntoConstraints   = false
        let padding: CGFloat                        = 2

        NSLayoutConstraint.activate([
            optionTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            optionTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            optionTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            optionTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionTextField.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }

}
