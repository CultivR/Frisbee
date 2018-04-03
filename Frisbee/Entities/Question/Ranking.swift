//
//  Ranking.swift
//  Frisbee
//
//  Created by Jordan Kay on 4/3/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public extension Question {
    struct Ranking {
        public let label: String
        public let rank: Int
    }
}

extension Question.Ranking: Decodable {
    public static func decode(_ json: Any) throws -> Question.Ranking {
        return try Question.Ranking(
            label: json => "label",
            rank: json => "rank"
        )
    }
}
