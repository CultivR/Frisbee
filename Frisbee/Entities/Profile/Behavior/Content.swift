//
//  InfoPiece.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/27/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public extension Profile.Behavior {
    struct Content {
        public let id: Int
        public let cardNumber: Int
        public let subtitle: String
        public let text: String
        public let behaviorID: Int
    }
}

extension Profile.Behavior.Content: Decodable {
    public static func decode(_ json: Any) throws -> Profile.Behavior.Content {
        return try Profile.Behavior.Content(
            id: json => "id",
            cardNumber: json => "attributes" => "card",
            subtitle: json => "attributes" => "subtitle",
            text: json => "attributes" => "text",
            behaviorID: json => "relationships" => "behavior" => "id"
        )
    }
}

extension Profile.Behavior.Content: Sqlable {
    public static let id = Column("id", .integer, PrimaryKey(autoincrement: false))
    public static let tableLayout = [id, cardNumber, subtitle, text, behaviorID]

    static let cardNumber = Column("cardNumber", .integer)
    static let subtitle = Column("subtitle", .text)
    static let text = Column("text", .text)
    static let behaviorID = Column("behaviorID", .integer)
    
    public init(row: ReadRow) throws {
        try self.init(
            id: row.get(Profile.Behavior.Content.id),
            cardNumber: row.get(Profile.Behavior.Content.cardNumber),
            subtitle: row.get(Profile.Behavior.Content.subtitle),
            text: row.get(Profile.Behavior.Content.text),
            behaviorID: row.get(Profile.Behavior.Content.behaviorID)
        )
    }
    
    public func valueForColumn(_ column: Column) -> SqlValue? {
        switch column {
        case Profile.Behavior.Content.id: return id
        case Profile.Behavior.Content.cardNumber: return cardNumber
        case Profile.Behavior.Content.subtitle: return subtitle
        case Profile.Behavior.Content.text: return text
        case Profile.Behavior.Content.behaviorID: return behaviorID
        default: return nil
        }
    }
}
