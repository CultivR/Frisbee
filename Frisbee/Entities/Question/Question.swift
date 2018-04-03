//
//  Question.swift
//  Frisbee
//
//  Created by Jordan Kay on 12/11/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Question {
    public let id: Int
    public let number: Int
    public let prompt: String
    public let answers: [Answer]?
    public let rankings: [Ranking]?
}

extension Question: Decodable {
    public static func decode(_ json: Any) throws -> Question {
        return try Question(
            id: json => "id",
            number: json => "attributes" => "number",
            prompt: json => "attributes" => "question",
            answers: json => "attributes" => "options",
            rankings: json => "attributes" => "rankings"
        )
    }
}
