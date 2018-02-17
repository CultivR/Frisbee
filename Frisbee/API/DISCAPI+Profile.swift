//
//  DISCAPI+Profile.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/15/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public typealias ProfileTask = Task<Float, Profile, Reason>
public typealias ProfilesTask = Task<Float, [Profile], Reason>

public extension DISCAPI {
    func createProfile(with traits: Profile.Traits) -> ProfileTask {
        return .init(
            value: .init(
                id: .randomID,
                name: nil,
                jobTitle: nil,
                company: nil,
                traits: traits,
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
    
    func update(_ profile: Profile, traits: Profile.Traits) -> ProfileTask {
        return .init(
            value: .init(
                id: profile.id,
                name: profile.name,
                jobTitle: profile.jobTitle,
                company: profile.company,
                traits: traits,
                behaviorID: profile.behaviorID
            )
        )
    }
}
