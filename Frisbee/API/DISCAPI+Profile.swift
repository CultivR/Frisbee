//
//  DISCAPI+Profile.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/15/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public typealias ProfileTask = Task<Float, Profile, Reason>

public extension DISCAPI {
    func createProfile() -> ProfileTask {
        return .init(
            value: .init(
                id: .randomID,
                name: nil,
                jobTitle: nil,
                company: nil,
                traits: .init(
                    dominantValue: 10,
                    interactiveValue: 10,
                    supportiveValue: 0,
                    conscientiousValue: 0
                ),
                behaviorID: 3
            )
        )
    }
    
    func update(_ profile: Profile, name: String, jobTitle: String?, company: String?) -> ProfileTask {
        return .init(
            value: .init(
                id: profile.id,
                name: name,
                jobTitle: jobTitle,
                company: company,
                traits: profile.traits,
                behaviorID: profile.behaviorID
            )
        )
    }
}
