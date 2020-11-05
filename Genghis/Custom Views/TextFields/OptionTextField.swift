//
//  OptionTextField.swift
//  Genghis
//
//  Created by Liana Haque on 10/1/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit

class OptionTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth           = 2
        layer.borderColor           = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        
        layer.cornerRadius          = 8
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .left
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        returnKeyType               = .done
        clearButtonMode             = .whileEditing
        placeholder                 = ""
    }

}
