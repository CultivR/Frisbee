//
//  Profile.swift
//  Frisbee
//
//  Created by Jordan Kay on 11/28/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Profile {
    public let name: String
    public let jobTitle: String?
    public let company: String?
    public let primaryBehavior: Behavior
    public let secondaryBehavior: Behavior
    
    public init(name: String, jobTitle: String?, company: String?, primaryBehavior: Behavior, secondaryBehavior: Behavior) {
        self.name = name
        self.jobTitle = jobTitle
        self.company = company
        self.primaryBehavior = primaryBehavior
        self.secondaryBehavior = secondaryBehavior
    }
}
