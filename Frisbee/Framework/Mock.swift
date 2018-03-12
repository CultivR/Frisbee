//
//  Mock.swift
//  Frisbee
//
//  Created by Jordan Kay on 3/11/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public extension Behavior {
    static func mock(trait: Trait, representation: Representation, color: Color) -> Behavior {
        return .init(trait: trait, representation: representation, color: color)
    }
}

public extension Behavior.Representation {
    static func mock(name: String, image: Image) -> Behavior.Representation {
        return .init(name: name, image: image)
    }
}

public extension Profile {
    static func mock(id: Int, name: String, company: String?, jobTitle: String?, traits: Traits, behaviorID: Int) -> Profile {
        return .init(id: id, name: name, company: company, jobTitle: jobTitle, traits: traits, behaviorID: behaviorID)
    }
}
