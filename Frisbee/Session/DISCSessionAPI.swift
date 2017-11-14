//
//  DISCSessionAPI.swift
//  Frisbee
//
//  Created by Jordan Kay on 10/21/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

import Emissary
import SwiftTask

public typealias RegistrationTask = Task<Float, Registration, Reason>

struct DISCSessionAPI: API {
    static var baseURL: URL! {
        return URL(string: "https://DISC.com/api")
    }
}
