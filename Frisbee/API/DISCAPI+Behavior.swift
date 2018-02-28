//
//  DISCAPI+Behavior.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/13/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public typealias BehaviorTask = Task<Float, Profile.Behavior, Reason>
public typealias BehaviorsTask = Task<Float, [Profile.Behavior.Base], Reason>

public extension DISCAPI {
    func fetchBehavior(withID id: Int) -> BehaviorTask {
        let path = Profile.Behavior.pathForBehavior(withID: id)
        return request(Resource(path: path, method: .get))
    }
    
    func fetchBehaviors(group: Profile.Behavior.Group? = nil) -> BehaviorsTask {
        let path = Profile.Behavior.pathForBehavior(withID: nil)
        let queryParameters = parameters(group: group)
        return request(containedResource(path: path, queryParameters: queryParameters, method: .get))
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

private func parameters(group: Profile.Behavior.Group?) -> [(String, String)]? {
    guard let group = group else { return nil }
    return [
        ("group_type", group.name)
    ]
}
