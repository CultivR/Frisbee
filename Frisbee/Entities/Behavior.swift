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
    public let color: Color
    public let keywords: String
}

public extension Behavior {
    enum Color: String {
        case red
        case yellow
        case green
        case blue
    }
    
    struct Representation {
        public let name: String
        public let image: Image
    }
}

public extension Behavior.Representation {
    enum Image: String {
        case eagle
        case parrot
        case dove
        case owl
    }
}

extension Behavior {
    init(name: String, colorName: String, representationName: String, representationImageName: String, keywords: String) {
        self.init(
            name: name,
            representation: .init(
                name: representationName,
                imageName: representationImageName
            ),
            color: .init(
                name: colorName
            ),
            keywords: keywords
        )
    }
}

private extension Behavior.Representation {
    init(name: String, imageName: String) {
        self.init(
            name: name,
            image: .init(
                name: imageName
            )
        )
    }
}
