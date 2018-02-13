//
//  DISCAPI+Behavior.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/13/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public typealias BehaviorsTask = Task<Float, [Profile.Behavior], Reason>

public extension DISCAPI {
    func fetchBehaviors() -> BehaviorsTask {
        let path = Profile.Behavior.pathForBehavior(withID: nil)
        return request(Resource(path: path, method: .get))
    }
}

extension Profile.Behavior: PathAccessible {
    public static var path: Path {
        return Path("behaviors")
    }
}

extension Profile.Behavior {
    static func pathForBehavior(withID id: Int?) -> Path {
        if let id = id {
            return path + "\(id)"
        }
        return path
    }
}
