//
//  Profile.swift
//  Frisbee
//
//  Created by Jordan Kay on 11/28/17.
//  Copyright © 2017 Cultivr. All rights reserved.
//

public struct Profile {
    public let id: Int
    public let name: String?
    public let jobTitle: String?
    public let company: String?
    public let traits: Traits
    public let behaviorID: Int
}

extension Profile: Decodable {
    public static func decode(_ json: Any) throws -> Profile {
        return try Profile(
            id: json => "id",
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
    static let jobTitle = Column("jobTitle", .nullable(.text))
    static let company = Column("company", .nullable(.text))
    static let dominantValue = Column("dominantValue", .integer)
    static let interactiveValue = Column("interactiveValue", .integer)
    static let supportiveValue = Column("supportiveValue", .integer)
    static let conscientiousValue = Column("conscientiousValue", .integer)
    static let behaviorID = Column("behaviorID", .integer)

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
        case Profile.behaviorID: return behaviorID
        default: return nil
        }
    }
}
