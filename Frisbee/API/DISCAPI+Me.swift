//
//  DISCAPI+Me.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/16/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public extension DISCAPI {
    func fetchMyBehavior(for id: Int) -> BehaviorTask {
        let path = .me + Profile.Behavior.pathForBehavior(withID: id)
        return request(Resource(path: path, method: .get))
    }
    
    func fetchMyQuestions() -> QuestionsTask {
        let path = .me + Question.path
        return request(containedResource(path: path, method: .get))
    }
}

private extension Path {
    static let me = Path("me")
}
