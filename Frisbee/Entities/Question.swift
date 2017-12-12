//
//  Question.swift
//  Frisbee
//
//  Created by Jordan Kay on 12/11/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Question {
    // public let id: Int
    public let prompt: String
    public let answers: [Answer]
    
    public init(prompt: String, answers: [Answer]) {
        self.prompt = prompt
        self.answers = answers
    }
}
