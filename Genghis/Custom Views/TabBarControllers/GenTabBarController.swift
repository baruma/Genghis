//
//  GenghisTabBarController.swift
//  Genghis
//
//  Created by Liana Haque on 9/26/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import UIKit

class GenTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = #colorLiteral(red: 1, green: 0.5411764706, blue: 0.5019607843, alpha: 1)
        
        viewControllers = [createQuestionsNC(), createSettingsNC()]
    }
    
    func createQuestionsNC() -> UINavigationController {
        let questionsVC        = QuestionsVC()
        questionsVC.title      = "Your Decisions"
        questionsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        return UINavigationController(rootViewController: questionsVC)
    }
    
    func createSettingsNC() -> UINavigationController {
        let settingsVC          = SettingsVC()
        settingsVC.title        = "Settings"
        #warning("Replace .more with Gear Symbol for Settings")
        settingsVC.tabBarItem   = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        return UINavigationController(rootViewController: settingsVC)
    }
}
