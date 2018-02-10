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
    public let dominantValue: Int
    public let interactiveValue: Int
    public let supportiveValue: Int
    public let conscientiousValue: Int
    
    public init(id: Int, name: String, jobTitle: String?, company: String?, dominantValue: Int, interactiveValue: Int, supportiveValue: Int, conscientiousValue: Int) {
        self.id = id
        self.name = name
        self.jobTitle = jobTitle
        self.company = company
        self.dominantValue = dominantValue
        self.interactiveValue = interactiveValue
        self.supportiveValue = supportiveValue
        self.conscientiousValue = conscientiousValue
    }
}

extension Profile: Decodable {
    public static func decode(_ json: Any) throws -> Profile {
        return try Profile(
            id: json => "id",
            name: json => "name",
            jobTitle: json => "job",
            company: json => "company",
            dominantValue: json => "dominant",
            interactiveValue: json => "interactive",
            supportiveValue: json => "supportive",
            conscientiousValue: json => "conscientious"
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
        dominantValue = try row.get(Profile.dominantValue)
        interactiveValue = try row.get(Profile.interactiveValue)
        supportiveValue = try row.get(Profile.supportiveValue)
        conscientiousValue = try row.get(Profile.conscientiousValue)
    }
    
    public func valueForColumn(_ column: Column) -> SqlValue? {
        switch column {
        case Profile.id: return id
        case Profile.name: return name
        case Profile.jobTitle: return jobTitle
        case Profile.company: return company
        case Profile.dominantValue: return dominantValue
        case Profile.interactiveValue: return interactiveValue
        case Profile.supportiveValue: return supportiveValue
        case Profile.conscientiousValue: return conscientiousValue
        default: return nil
        }
    }
}
