//
//  Behavior.swift
//  Frisbee
//
//  Created by Jordan Kay on 11/17/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Behavior {
    public let name: String
    public let representation: Representation
    public let traits: [String]
    
    public init(name: String, representation: Representation, traits: [String]) {
        self.name = name
        self.representation = representation
        self.traits = traits
    }
}
