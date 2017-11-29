//
//  Profile.swift
//  Frisbee
//
//  Created by Jordan Kay on 11/28/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Profile {
    public let name: String
    public let behaviors: [Behavior]
    
    public init(name: String, behaviors: [Behavior]) {
        self.name = name
        self.behaviors = behaviors
    }
    
    public var salientBehaviors: [Behavior] {
        return Array(behaviors.prefix(.salientBehaviorMax))
    }
}

private extension Int {
    static let salientBehaviorMax = 2
}
