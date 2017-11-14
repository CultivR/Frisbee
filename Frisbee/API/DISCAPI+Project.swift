//
//  DISCAPI+Project.swift
//  Frisbee
//
//  Created by Jordan Kay on 10/26/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

import Emissary
import SwiftTask

public typealias ProjectTask = Task<Float, Project, Reason>
public typealias ProjectsTask = Task<Float, [Project], Reason>

public extension DISCAPI {
    func fetchPublicProjects() -> ProjectsTask {
        let path = Path("public")
        let queryParameters = [("filter", "featured"), ("limit", "20")]
        return request(Resource(path: path, queryParameters: queryParameters, method: .get))
    }
}
