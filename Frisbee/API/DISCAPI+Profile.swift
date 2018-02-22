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
    func createProfile(name: String?, company: String?, jobTitle: String?, traits: Profile.Traits) -> ProfileTask {
        return .init(
            value: .init(
                id: .randomID,
                name: name,
                company: company,
                jobTitle: jobTitle,
                traits: traits,
                behaviorID: 3
            )
        )
    }
    
    func update(_ profile: Profile, name: String?, company: String?, jobTitle: String?, traits: Profile.Traits?) -> ProfileTask {
        return .init(
            value: .init(
                id: profile.id,
                name: name ?? profile.name,
                company: company ?? profile.company,
                jobTitle: jobTitle ?? profile.jobTitle,
                traits: traits ?? profile.traits,
                behaviorID: profile.behaviorID
            )
        )
    }
}
