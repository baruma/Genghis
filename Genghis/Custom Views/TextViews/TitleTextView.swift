//
//  TitleTextView.swift
//  Genghis
//
//  Created by Liana Haque on 10/1/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit

class TitleTextView: UITextView {

    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        let edgeInset: CGFloat = 30
        layer.cornerRadius = 10
        layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        textColor                                   = .label
        tintColor                                   = .label
        textAlignment                               = .left
        textContainerInset                          = UIEdgeInsets(top: 10, left: edgeInset, bottom: edgeInset, right: edgeInset)
        font                                        = UIFont.preferredFont(forTextStyle: .headline)
        font                                        = .systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 2))
        backgroundColor                             = #colorLiteral(red: 0.9764705882, green: 0.9607843137, blue: 0.831372549, alpha: 1)
                        
        backgroundColor                             = .tertiarySystemBackground
        autocorrectionType                          = .no
        returnKeyType                               = .done
                    
        allowsEditingTextAttributes                 = true
        isEditable                                  = true
    }
}
