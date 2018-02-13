//
//  Profile.swift
//  Frisbee
//
//  Created by Jordan Kay on 11/28/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

import protocol Decodable.Decodable
import Decodable
import Sqlable

public struct Profile {
    public let id: Int
    public let name: String
    public let jobTitle: String?
    public let company: String?
    public let traits: Traits
    public let behaviorID: Int
}

extension Profile: Decodable {
    public static func decode(_ json: Any) throws -> Profile {
        return try Profile(
            id: json => "attributes" => "id",
            name: json => "attributes" => "name",
            jobTitle: json => "attributes" => "job",
            company: json => "attributes" => "company",
            traits: json => "attributes" => "traits",
            behaviorID: json => "relationships" => "behavior" => "data" => "id" as Int
        )
    }
}

extension Profile: Sqlable {
    public static let tableLayout = [id, name, jobTitle, company, dominantValue, interactiveValue, supportiveValue, conscientiousValue, behaviorID]

    static let id = Column("id", .integer, PrimaryKey(autoincrement: false))
    static let name = Column("name", .text)
    static let jobTitle = Column("jobTitle", .text)
    static let company = Column("company", .text)
    static let behaviorID = Column("behaviorID", .integer)
    static let dominantValue = Column("dominantValue", .integer)
    static let interactiveValue = Column("interactiveValue", .integer)
    static let supportiveValue = Column("supportiveValue", .integer)
    static let conscientiousValue = Column("conscientiousValue", .integer)
    
    public init(row: ReadRow) throws {
        try self.init(
            id: row.get(Profile.id),
            name: row.get(Profile.name),
            jobTitle: row.get(Profile.jobTitle),
            company: row.get(Profile.company),
            traits: .init(
                dominantValue: row.get(Profile.dominantValue),
                interactiveValue: row.get(Profile.interactiveValue),
                supportiveValue: row.get(Profile.supportiveValue),
                conscientiousValue: row.get(Profile.conscientiousValue)
            ),
            behaviorID: row.get(Profile.behaviorID)
        )
    }
    
    public func valueForColumn(_ column: Column) -> SqlValue? {
        switch column {
        case Profile.id: return id
        case Profile.name: return name
        case Profile.jobTitle: return jobTitle
        case Profile.company: return company
        case Profile.dominantValue: return traits.dominantValue
        case Profile.interactiveValue: return traits.interactiveValue
        case Profile.supportiveValue: return traits.supportiveValue
        case Profile.conscientiousValue: return traits.conscientiousValue
        default: return nil
        }
    }
}

public extension Profile {
    struct Traits {
        public let dominantValue: Int
        public let interactiveValue: Int
        public let supportiveValue: Int
        public let conscientiousValue: Int
    }
    
    struct Behavior {
        public let id: Int
        public let primaryBehavior: Frisbee.Behavior
        public let secondaryBehavior: Frisbee.Behavior?
        public let keywords: String
        public let group: Group
    }
}

extension Profile.Traits: Decodable {
    public static func decode(_ json: Any) throws -> Profile.Traits {
        return try Profile.Traits(
            dominantValue: json => "dominant",
            interactiveValue: json => "interactive",
            supportiveValue: json => "supportive",
            conscientiousValue: json => "conscientious"
        )
    }
}

public extension Profile.Behavior {
    enum Group: String {
        case singular
        case dual
    }
}

extension Profile.Behavior: Decodable {
    public static func decode(_ json: Any) throws -> Profile.Behavior {
        return try Profile.Behavior(
            id: json => "id",
            primaryName: json => "attributes" => "primary_trait",
            primaryColorName: json => "attributes" => "primary_color",
            primaryRepresentationName: json => "attributes" => "primary_name",
            primaryRepresentationImageName: json => "attributes" => "primary_image",
            secondaryName: json => "attributes" => "secondary_trait",
            secondaryColorName: json => "attributes" => "secondary_color",
            secondaryRepresentationName: json => "attributes" => "secondary_name",
            secondaryRepresentationImageName: json => "attributes" => "secondary_image",
            keywords: json => "attributes" => "keywords",
            groupName: json => "attributes" => "group_type"
        )
    }
}

extension Profile.Behavior: Sqlable {
    public static let tableLayout = [id, primaryName, primaryColorName, primaryRepresentationName, primaryRepresentationImageName, secondaryName, secondaryColorName, secondaryRepresentationName, secondaryRepresentationImageName, keywords]
    
    static let id = Column("id", .integer, PrimaryKey(autoincrement: false))
    static let primaryName = Column("primaryName", .text)
    static let primaryColorName = Column("primaryColorName", .text)
    static let primaryRepresentationName = Column("primaryRepresentationName", .text)
    static let primaryRepresentationImageName = Column("primaryRepresentationImageName", .text)
    static let secondaryName = Column("secondaryName", .text)
    static let secondaryColorName = Column("secondaryColorName", .text)
    static let secondaryRepresentationName = Column("secondaryRepresentationName", .text)
    static let secondaryRepresentationImageName = Column("secondaryRepresentationImageName", .text)
    static let keywords = Column("keywords", .text)
    static let groupName = Column("groupName", .text)
    
    public init(row: ReadRow) throws {
        try self.init(
            id: row.get(Profile.Behavior.id),
            primaryName: row.get(Profile.Behavior.primaryName),
            primaryColorName: row.get(Profile.Behavior.primaryColorName),
            primaryRepresentationName: row.get(Profile.Behavior.primaryRepresentationName),
            primaryRepresentationImageName: row.get(Profile.Behavior.primaryRepresentationImageName),
            secondaryName: row.get(Profile.Behavior.secondaryName),
            secondaryColorName: row.get(Profile.Behavior.secondaryColorName),
            secondaryRepresentationName: row.get(Profile.Behavior.secondaryRepresentationName),
            secondaryRepresentationImageName: row.get(Profile.Behavior.secondaryRepresentationImageName),
            keywords: row.get(Profile.Behavior.keywords),
            groupName: row.get(Profile.Behavior.groupName)
        )
    }
    
    public func valueForColumn(_ column: Column) -> SqlValue? {
        switch column {
        case Profile.Behavior.id: return id
        case Profile.Behavior.primaryName: return primaryBehavior.name
        case Profile.Behavior.primaryColorName: return primaryBehavior.color.rawValue
        case Profile.Behavior.primaryRepresentationName: return primaryBehavior.representation.name
        case Profile.Behavior.primaryRepresentationImageName: return primaryBehavior.representation.image.rawValue
        case Profile.Behavior.secondaryName: return secondaryBehavior?.name
        case Profile.Behavior.secondaryColorName: return secondaryBehavior?.color.rawValue
        case Profile.Behavior.secondaryRepresentationName: return secondaryBehavior?.representation.name
        case Profile.Behavior.secondaryRepresentationImageName: return secondaryBehavior?.representation.image.rawValue
        case Profile.Behavior.keywords: return keywords
        case Profile.Behavior.groupName: return group.rawValue
        default: return nil
        }
    }
}

private extension Profile.Behavior {
    init(id: Int, primaryName: String, primaryColorName: String, primaryRepresentationName: String, primaryRepresentationImageName: String, secondaryName: String, secondaryColorName: String, secondaryRepresentationName: String, secondaryRepresentationImageName: String, keywords: String, groupName: String) {
        self.init(
            id: id,
            primaryBehavior: .init(
                name: primaryName,
                colorName: primaryColorName,
                representationName: primaryRepresentationName,
                representationImageName: primaryRepresentationImageName)
            ,
            secondaryBehavior: .init(
                name: secondaryName,
                colorName: secondaryColorName,
                representationName: secondaryRepresentationName,
                representationImageName: secondaryRepresentationImageName
            ),
            keywords: keywords,
            group: .init(
                name: groupName
            )
        )
    }
}
