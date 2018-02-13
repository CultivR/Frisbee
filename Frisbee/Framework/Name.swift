//
//  Name.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/13/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

extension RawRepresentable where RawValue == String {
    var name: String {
        return rawValue
    }
    
    init(name: String) {
        self.init(rawValue: name)!
    }
}
