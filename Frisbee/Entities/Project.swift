//
//  Project.swift
//  Frisbee
//
//  Created by Jordan Kay on 10/26/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

import protocol Decodable.Decodable
import Decodable

public struct Project {
    public let id: Int
    public let title: String
    public let description: String
    public let author: User
    public let imageURL: URL?
    public let branchCount: Int
    public let commentCount: Int
    public let viewCount: Int
    public let completionCount: Int
}

extension Project: Decodable {
    public static func decode(_ json: Any) throws -> Project {
        return try Project(
            id: json => "id",
            title: json => "title",
            description: json => "description",
            author: json => "authorObj",
            imageURL: json => "image" => "url",
            branchCount: json => "branches",
            commentCount: json => "comments",
            viewCount: json => "statistics" => "projview",
            completionCount: json => "statistics" => "projcomp"
        )
    }
}

extension Project: Hashable {
    public var hashValue: Int {
        return id
    }
}

extension Project: Equatable {
    public static func ==(lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id
    }
}
