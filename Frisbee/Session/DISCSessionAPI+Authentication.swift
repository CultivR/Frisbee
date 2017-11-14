//
//  DISCSessionAPI+Authentication.swift
//  Cultivr
//
//  Created by Jordan Kay on 8/10/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

import SwiftTask

extension DISCSessionAPI {
    func createSession(email: String, password: String) -> DISCAPITask {
        return .mock
    }
    
    func signUp(fullName: String, password: String, email: String) -> RegistrationTask {
        return .mock
    }
}
