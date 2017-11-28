//
//  Behavior.swift
//  Frisbee
//
//  Created by Jordan Kay on 11/17/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Behavior {
    public let description: String
    public let representation: Representation
    public let traits: [String]
    
    public init(description: String, representation: Representation, traits: [String]) {
        self.description = description
        self.representation = representation
        self.traits = traits
    }
}
