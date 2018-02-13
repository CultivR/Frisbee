//
//  User.swift
//  Frisbee
//
//  Created by Jordan Kay on 10/21/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

import protocol Decodable.Decodable
import Decodable

public struct User {
    public let name: String
    public let username: String
}

extension User: Decodable {
    public static func decode(_ json: Any) throws -> User {
        return try User(
            name: json => "name",
            username: json => "username"
        )
    }
}
