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
    
    public init(id: Int, name: String, jobTitle: String?, company: String?, traits: Traits) {
        self.id = id
        self.name = name
        self.jobTitle = jobTitle
        self.company = company
        self.traits = traits
    }
}

extension Profile: Decodable {
    public static func decode(_ json: Any) throws -> Profile {
        return try Profile(
            id: json => "id",
            name: json => "name",
            jobTitle: json => "job",
            company: json => "company",
            traits: json => "traits"
        )
    }
}

extension Profile: Sqlable {
    public static let tableLayout = [id, name, jobTitle, company, dominantValue, interactiveValue, supportiveValue, conscientiousValue]

    static let id = Column("id", .integer, PrimaryKey(autoincrement: false))
    static let name = Column("name", .text)
    static let jobTitle = Column("jobTitle", .text)
    static let company = Column("company", .text)
    static let dominantValue = Column("dominantValue", .integer)
    static let interactiveValue = Column("interactiveValue", .integer)
    static let supportiveValue = Column("supportiveValue", .integer)
    static let conscientiousValue = Column("conscientiousValue", .integer)
    
    public init(row: ReadRow) throws {
        id = try row.get(Profile.id)
        name = try row.get(Profile.name)
        jobTitle = try row.get(Profile.jobTitle)
        company = try row.get(Profile.company)
        
        let dominantValue: Int = try row.get(Profile.dominantValue)
        let interactiveValue: Int = try row.get(Profile.interactiveValue)
        let supportiveValue: Int = try row.get(Profile.supportiveValue)
        let conscientiousValue: Int = try row.get(Profile.conscientiousValue)
        traits = Traits(dominantValue: dominantValue, interactiveValue: interactiveValue, supportiveValue: supportiveValue, conscientiousValue: conscientiousValue)
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
