//
//  Traits.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/13/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public extension Profile {
    struct Traits {
        public let dominantValue: Int
        public let interactiveValue: Int
        public let supportiveValue: Int
        public let conscientiousValue: Int
        
        public var rankedValues: [Int] {
            return [dominantValue, interactiveValue, supportiveValue, conscientiousValue].sorted().reversed()
        }
        
        var rankedTraits: [Frisbee.Behavior.Trait] {
            return rankedValues.map(trait)
        }
        
        public init(dominantValue: Int, interactiveValue: Int, supportiveValue: Int, conscientiousValue: Int) {
            self.dominantValue = dominantValue
            self.interactiveValue = interactiveValue
            self.supportiveValue = supportiveValue
            self.conscientiousValue = conscientiousValue
        }
        
        public init() {
            self.init(dominantValue: 0, interactiveValue: 0, supportiveValue: 0, conscientiousValue: 0)
        }
    }
}

extension Profile.Traits: Decodable {
    public static func decode(_ json: Any) throws -> Profile.Traits {
        return try Profile.Traits(
            dominantValue: json => "dominant",
            interactiveValue: json => "interactive",
            supportiveValue: json => "supportive",
            conscientiousValue: json => "conscientious"
        )
    }
}

private extension Profile.Traits {
    func trait(forValue value: Int) -> Frisbee.Behavior.Trait! {
        switch value {
        case dominantValue:
            return .dominant
        case interactiveValue:
            return .interactive
        case supportiveValue:
            return .supportive
        case conscientiousValue:
            return .conscientious
        default:
            return nil
        }
    }
}
