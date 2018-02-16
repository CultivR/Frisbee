//
//  Behavior.swift
//  Frisbee
//
//  Created by Jordan Kay on 11/17/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Behavior {
    public let trait: Trait
    public let representation: Representation
    public let color: Color
}

extension Behavior {
    init(name: String, colorName: String, representationName: String, representationImageName: String) {
        self.init(
            trait: .init(
                name: name
            ),
            representation: .init(
                name: representationName,
                image: .init(
                    name: representationImageName
                )
            ),
            color: .init(
                name: colorName
            )
        )
    }
}
