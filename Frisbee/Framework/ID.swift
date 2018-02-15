//
//  ID.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/15/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

extension Int {
    static var randomID: Int {
        return Int(arc4random_uniform(UInt32.max))
    }
}
