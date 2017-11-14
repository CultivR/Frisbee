//
//  DISCSession.swift
//  Formosa
//
//  Created by Jordan Kay on 5/23/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

import protocol Decodable.Decodable
import Decodable
import Emissary
import Province
import SwiftTask
import KeychainAccess

public typealias DISCAuthenticationState = AuthenticationState<DISCAPI, Registration, Reason>

public final class DISCSession {
    public var runningLogInTask: DISCAPITask?
    public var runningLogOutTask: BasicTask?
    public var runningRestoreLoginTask: DISCAPITask?
    public var runningSignUpTask: RegistrationTask?
    
    public var authenticationState: DISCAuthenticationState = .unauthenticated
}

extension DISCSession: Session {
    public static let current = DISCSession()
    
    public static var logOutTask: BasicTask {
        return .mock
    }
    
    public static var restoreLoginTask: DISCAPITask {
        return .mock
    }
    
    public static func logInTask(credentials: [DISCCredential: String] = [:]) -> DISCAPITask {
        let email = credentials[.email]!
        let password = credentials[.password]!
        return DISCSessionAPI().createSession(email: email, password: password)
    }
    
    public static func signUpTask(credentials: [DISCCredential: String] = [:]) -> RegistrationTask {
        let fullName = credentials[.fullName]!
        let email = credentials[.email]!
        let password = credentials[.password]!
        return DISCSessionAPI().signUp(fullName: fullName, password: password, email: email)
    }
}

extension DISCSession: PathAccessible {
    public static var path: Path {
        return Path("oauth", "v2", "token")
    }
}

private extension DISCSession {
    func register(_ api: DISCAPI) {
        api.authToken!.storeInKeychain(withIdentifier: .authToken, encode: AuthToken.encode)
    }
    
    func deregister() {
        AuthToken.removeFromKeychain(withIdentifier: .authToken)
    }
}

extension AuthToken: Decodable {
    public static func decode(_ json: Any) throws -> AuthToken {
        return try AuthToken(
            accessToken: json => "access_token",
            refreshToken: json => "refresh_token",
            creationDate: json => "created",
            expirationDate: json => "expires_in"
        )
    }
}

private extension AuthToken {
    static func encode(_ authToken: AuthToken) -> [String: Any] {
        return [
            "access_token": authToken.accessToken,
            "refresh_token": authToken.refreshToken,
            "created": authToken.creationDate,
            "expires_in": authToken.expirationDuration as Any
        ]
    }
}

private extension String {
    static let authToken = "authToken"
}
