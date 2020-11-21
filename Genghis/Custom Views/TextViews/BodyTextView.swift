//
//  BodyTextView.swift
//  Genghis
//
//  Created by Liana Haque on 11/4/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit

class BodyTextView: UITextView {

    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        let edgeInset: CGFloat = 20
        
        layer.cornerRadius = 10
        
        textColor                                   = .label
        tintColor                                   = .label
        textAlignment                               = .left
        textContainerInset                          = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
        font                                        = UIFont.preferredFont(forTextStyle: .subheadline)
        backgroundColor                             = .systemGray6
        isScrollEnabled                             = false
        
        autocorrectionType                          = .no
        returnKeyType                               = .done
    
        allowsEditingTextAttributes                 = true
        isEditable                                  = true
    }
}
