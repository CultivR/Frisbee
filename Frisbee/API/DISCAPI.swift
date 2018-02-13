//
//  DISCAPI.swift
//  Cultivr
//
//  Created by Jordan Kay on 8/10/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct DISCAPI {
    public init() {}
}

extension DISCAPI: API {
    public static var baseURL: URL! {
        return Bundle.main.bundleURL
    }
    
    public static var containerKeyPath: KeyPath? {
        return "data"
    }
    
    public static var requestsUseContainerKeyPath: Bool {
        return true
    }
}
