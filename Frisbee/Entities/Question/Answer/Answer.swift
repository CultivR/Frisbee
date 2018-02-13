//
//  Answer.swift
//  Frisbee
//
//  Created by Jordan Kay on 12/11/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public extension Question {
    struct Answer {
        public let text: String
        public let value: Behavior.Value
    }
}

extension Question.Answer: Decodable {
    public static func decode(_ json: Any) throws -> Question.Answer {
        return try Question.Answer(
            text: json => "text",
            valueName: json => "value"
        )
    }
}

private extension Question.Answer {
    init(text: String, valueName: String) {
        self.init(
            text: text,
            value: .init(
                name: valueName
            )
        )
    }
}
