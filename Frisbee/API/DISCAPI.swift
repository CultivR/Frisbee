//
//  DISCAPI.swift
//  Cultivr
//
//  Created by Jordan Kay on 8/10/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

import Emissary
import SwiftTask

public typealias BasicTask = Task<Float, Void, Reason>
public typealias DISCAPITask = Task<Float, DISCAPI, Reason>

public struct DISCAPI {
    public let user: User?
    public let authToken: AuthToken?
    
    public init() {
        user = nil
        authToken = nil
    }
}

extension DISCAPI: API {
    public var authorization: Authorization? {
        return authToken.map { .bearer(credentials: $0.accessToken)}
    }
    
    public static var baseURL: URL! {
        return URL(string: "https://DISC.com/api/mobile")
    }
    
    public static var pathsUseTrailingSlash: Bool {
        return true
    }
    
    public static var dateFormat: String? {
        return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }
    
    public static var injectedScheme: String? {
        return "http"
    }
}

// TODO
public extension Task where Progress == Float, Error == Reason {
    static var mock: Task<Progress, Value, Error> {
        return Task { _, fulfill, reject, _ in

        }
    }
}
