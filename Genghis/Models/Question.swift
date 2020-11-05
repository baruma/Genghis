//
//  Question.swift
//  Genghis
//
//  Created by Liana Haque on 10/26/20.
//  Copyright © 2020 Liana Haque. All rights reserved.
//

import Foundation

struct Question {
    public var id: UUID
    public var title: String
    public var lastUpdated: Date
    public var options: [String]
    
    init(id: UUID, title: String, lastUpdated: Date, options: [String]) {
        self.id = id
        self.title = title
        self.lastUpdated = lastUpdated
        self.options = options
    }
}
