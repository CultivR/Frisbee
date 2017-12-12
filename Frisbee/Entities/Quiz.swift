//
//  Quiz.swift
//  Frisbee
//
//  Created by Jordan Kay on 12/11/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Quiz {
    public let questions: [Question] // TODO: questionIDs
    
    public init(questions: [Question]) {
        self.questions = questions
    }
}
