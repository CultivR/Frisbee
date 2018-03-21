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
                behaviorID: traits.behaviorID
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
                behaviorID: traits?.behaviorID ?? profile.behaviorID
            )
        )
    }
}

public extension Profile.Traits {
    var rankedBehaviorIDs: [Int] {
        return rankedTraits.map {
            switch $0 {
            case .dominant:
                return 1
            case .interactive:
                return 5
            case .supportive:
                return 9
            case .conscientious:
                return 13
            }
        }
    }
}

private extension Profile.Traits {
    var behaviorID: Int! {
        let primaryTrait = rankedTraits[0]
        let secondaryTrait = rankedTraits[1]
        switch (primaryTrait, secondaryTrait) {
        case (.dominant, .conscientious):
            return 2
        case (.dominant, .interactive):
            return 3
        case (.dominant, .supportive):
            return 4
        case (.interactive, .dominant):
            return 6
        case (.interactive, .supportive):
            return 7
        case (.interactive, .conscientious):
            return 8
        case (.supportive, .interactive):
            return 10
        case (.supportive, .conscientious):
            return 11
        case (.supportive, .dominant):
            return 12
        case (.conscientious, .dominant):
            return 14
        case (.conscientious, .supportive):
            return 15
        case (.conscientious, .interactive):
            return 16
        default:
            return nil
        }
    }
}
