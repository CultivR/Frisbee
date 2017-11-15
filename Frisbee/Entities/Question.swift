//
//  User.swift
//  Frisbee
//
//  Created by Jordan Kay on 10/21/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

import protocol Decodable.Decodable
import Decodable

public struct Question {
    
}

extension Question: Decodable {
    public static func decode(_ json: Any) throws -> Question {
        return Question(

        )
    }
}

