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
                behaviorID: .randomBehaviorID
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

private extension Int {
    static var randomBehaviorID: Int {
        let ids = [2, 3, 6, 7, 10, 11, 14, 15]
        return ids[Int(arc4random_uniform(UInt32(ids.count)))]
    }
}
