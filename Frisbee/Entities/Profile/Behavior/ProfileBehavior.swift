//
//  ProfileBehavior.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/13/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public extension Profile {
    struct Behavior {
        public let base: Base
        public let contents: [Content]
    }
}

public extension Profile.Behavior {
    struct Base {
        public let id: Int
        public let primaryBehavior: Frisbee.Behavior
        public let secondaryBehavior: Frisbee.Behavior?
        public let keywords: String
        public let group: Group
    }
}

extension Profile.Behavior: Decodable {
    public static func decode(_ json: Any) throws -> Profile.Behavior {
        return try Profile.Behavior(
            base: json => "data",
            contents: json => "included"
        )
    }
}

extension Profile.Behavior.Base: Decodable {
    public static func decode(_ json: Any) throws -> Profile.Behavior.Base {
        return try Profile.Behavior.Base(
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

extension Profile.Behavior.Base: Sqlable {
    public static let tableLayout = [id, primaryName, primaryColorName, primaryRepresentationName, primaryRepresentationImageName, secondaryName, secondaryColorName, secondaryRepresentationName, secondaryRepresentationImageName, keywords, groupName]
    
    static let id = Column("id", .integer, PrimaryKey(autoincrement: false))
    static let primaryName = Column("primaryName", .text)
    static let primaryColorName = Column("primaryColorName", .text)
    static let primaryRepresentationName = Column("primaryRepresentationName", .text)
    static let primaryRepresentationImageName = Column("primaryRepresentationImageName", .text)
    static let secondaryName = Column("secondaryName", .nullable(.text))
    static let secondaryColorName = Column("secondaryColorName", .nullable(.text))
    static let secondaryRepresentationName = Column("secondaryRepresentationName", .nullable(.text))
    static let secondaryRepresentationImageName = Column("secondaryRepresentationImageName", .nullable(.text))
    static let keywords = Column("keywords", .text)
    static let groupName = Column("groupName", .text)
    
    public init(row: ReadRow) throws {
        try self.init(
            id: row.get(Profile.Behavior.Base.id),
            primaryName: row.get(Profile.Behavior.Base.primaryName),
            primaryColorName: row.get(Profile.Behavior.Base.primaryColorName),
            primaryRepresentationName: row.get(Profile.Behavior.Base.primaryRepresentationName),
            primaryRepresentationImageName: row.get(Profile.Behavior.Base.primaryRepresentationImageName),
            secondaryName: row.get(Profile.Behavior.Base.secondaryName),
            secondaryColorName: row.get(Profile.Behavior.Base.secondaryColorName),
            secondaryRepresentationName: row.get(Profile.Behavior.Base.secondaryRepresentationName),
            secondaryRepresentationImageName: row.get(Profile.Behavior.Base.secondaryRepresentationImageName),
            keywords: row.get(Profile.Behavior.Base.keywords),
            groupName: row.get(Profile.Behavior.Base.groupName)
        )
    }
    
    public func valueForColumn(_ column: Column) -> SqlValue? {
        switch column {
        case Profile.Behavior.Base.id: return id
        case Profile.Behavior.Base.primaryName: return primaryBehavior.trait.name
        case Profile.Behavior.Base.primaryColorName: return primaryBehavior.color.name
        case Profile.Behavior.Base.primaryRepresentationName: return primaryBehavior.representation.name
        case Profile.Behavior.Base.primaryRepresentationImageName: return primaryBehavior.representation.image.name
        case Profile.Behavior.Base.secondaryName: return secondaryBehavior?.trait.name
        case Profile.Behavior.Base.secondaryColorName: return secondaryBehavior?.color.name
        case Profile.Behavior.Base.secondaryRepresentationName: return secondaryBehavior?.representation.name
        case Profile.Behavior.Base.secondaryRepresentationImageName: return secondaryBehavior?.representation.image.name
        case Profile.Behavior.Base.keywords: return keywords
        case Profile.Behavior.Base.groupName: return group.name
        default: return nil
        }
    }
}

private extension Profile.Behavior.Base {
    init(id: Int, primaryName: String, primaryColorName: String, primaryRepresentationName: String, primaryRepresentationImageName: String, secondaryName: String?, secondaryColorName: String?, secondaryRepresentationName: String?, secondaryRepresentationImageName: String?, keywords: String, groupName: String) {
        self.init(
            id: id,
            primaryBehavior: .init(
                name: primaryName,
                colorName: primaryColorName,
                representationName: primaryRepresentationName,
                representationImageName: primaryRepresentationImageName
            ),
            secondaryBehavior: secondaryName.flatMap { name in
                secondaryColorName.flatMap { colorName in
                    secondaryRepresentationName.flatMap { representationName in
                        secondaryRepresentationImageName.map { representationImageName in
                            .init(
                                name: name,
                                colorName: colorName,
                                representationName: representationName,
                                representationImageName: representationImageName
                            )
                        }
                    }
                }
            },
            keywords: keywords,
            group: .init(
                name: groupName
            )
        )
    }
}
