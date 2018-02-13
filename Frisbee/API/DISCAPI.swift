//
//  DISCAPI.swift
//  Cultivr
//
//  Created by Jordan Kay on 8/10/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

import Emissary
import SwiftTask

public struct DISCAPI: API {
    public static var baseURL: URL! {
        return Bundle.main.bundleURL
    }
}
