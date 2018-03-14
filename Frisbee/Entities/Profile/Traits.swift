//
//  Traits.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/13/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public extension Profile {
    struct Traits {
        private let values: [Frisbee.Behavior.Trait: Int]
        
        public var dominantValue: Int {
            return values[.dominant]!
        }
        
        public var interactiveValue: Int {
            return values[.interactive]!
        }
        
        public var supportiveValue: Int {
            return values[.supportive]!
        }
        
        public var conscientiousValue: Int {
            return values[.conscientious]!
        }
        
        public var rankedValues: [(Frisbee.Behavior.Trait, Int)] {
            return values.sorted { $0.value > $1.value }
        }
        
        var rankedTraits: [Frisbee.Behavior.Trait] {
            return rankedValues.map { $0.0 }
        }
        
        public init(values: [Frisbee.Behavior.Trait: Int] = [:]) {
            self.values = values
        }
        
        init(dominantValue: Int, interactiveValue: Int, supportiveValue: Int, conscientiousValue: Int) {
            values = [
                .dominant: dominantValue,
                .interactive: interactiveValue,
                .supportive: supportiveValue,
                .conscientious: conscientiousValue
            ]
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
