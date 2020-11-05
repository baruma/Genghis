//
//  TitleTextField.swift
//  Genghis
//
//  Created by Liana Haque on 10/1/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit

class TitleTextField: UITextField {

    // Backup mostly in case titletextview doesn't work out
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 20
        layer.borderWidth           = 1
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .left
        
        font                        = .systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 2))
        adjustsFontSizeToFitWidth   = true

        minimumFontSize             = 28
        
        backgroundColor             = .black
        autocorrectionType          = .no
        returnKeyType               = .done
        clearButtonMode             = .unlessEditing
        placeholder                 = "What is it that Genghis must solve?"  // have rotating dumb silly quote to ask the user
    }
}
