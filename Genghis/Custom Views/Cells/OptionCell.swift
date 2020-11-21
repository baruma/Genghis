//
//  OptionCell.swift
//  Genghis
//
//  Created by Liana Haque on 10/2/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit

protocol OptionTextChangeListener {
    func onTextChange(row: Int, text: String)
}

class OptionCell: UITableViewCell, UITextViewDelegate {
    
    static let reuseID = "OptionCell"
    let optionTextView = BodyTextView(frame: .zero)
    var textChangeListener: OptionTextChangeListener? = nil
    
    var rowIndex = -1 //todo : set this

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
    
    func setTextChangeListener(listener: OptionTextChangeListener) {  
        textChangeListener = listener
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChangeListener?.onTextChange(row: rowIndex, text: optionTextView.text)
    }
    
    private func configure() {
        contentView.addSubview(optionTextView)
        optionTextView.delegate = self
        optionTextView.textColor                    = .systemGray
        self.selectionStyle                         = .none
        translatesAutoresizingMaskIntoConstraints   = false
        let padding: CGFloat                        = 40

        NSLayoutConstraint.activate([
            optionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            optionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            optionTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            optionTextView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionTextView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

