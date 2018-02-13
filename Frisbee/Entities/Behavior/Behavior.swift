//
//  Behavior.swift
//  Frisbee
//
//  Created by Jordan Kay on 11/17/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Behavior {
    public let value: Value
    public let representation: Representation
    public let color: Color
}

extension Behavior {
    init(name: String, colorName: String, representationName: String, representationImageName: String) {
        self.init(
            value: .init(
                name: name
            ),
            representation: .init(
                name: representationName,
                imageName: representationImageName
            ),
            color: .init(
                name: colorName
            )
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
