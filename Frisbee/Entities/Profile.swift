//
//  Profile.swift
//  Frisbee
//
//  Created by Jordan Kay on 11/28/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Profile {
    public let name: String
    public let behavior: Behavior
    
    public init(name: String, behavior: Behavior) {
        self.name = name
        self.behavior = behavior
    }
}
