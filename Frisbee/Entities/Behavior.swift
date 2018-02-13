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
    
    init(name: String, colorName: String, representationName: String, representationImageName: String) {
        self.name = name
        representation = .init(name: representationName, imageName: representationImageName)
        color = .init(name: colorName)
    }
}

public extension Behavior {
    enum Color {
        case red
        case yellow
        case green
        case blue
    }
    
    struct Representation {
        public enum Image {
            case eagle
            case parrot
            case dove
            case owl
        }
        
        public let name: String
        public let image: Image
        
        fileprivate init(name: String, imageName: String) {
            self.name = name
            image = .init(name: imageName)
        }
    }
}

private extension Behavior.Color {
    init!(name: String) {
        switch name {
        case "red": self = .red
        case "yellow": self = .yellow
        case "green": self = .green
        case "blue": self = .blue
        default: return nil
        }
    }
}

private extension Behavior.Representation.Image {
    init!(name: String) {
        switch name {
        case "eagle": self = .eagle
        case "parrot": self = .parrot
        case "dove": self = .dove
        case "owl": self = .owl
        default: return nil
        }
    }
}
