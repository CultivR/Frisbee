//
//  DISCAPI+Question.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/14/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public typealias QuestionsTask = Task<Float, [Question], Reason>

public extension DISCAPI {
    func fetchQuestions() -> QuestionsTask {
        let path = Question.path
        return request(containedResource(path: path, method: .get))
    }
}

extension Question: PathAccessible {
    public static var path: Path {
        return Path("questions")
    }
}
