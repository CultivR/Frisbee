//
//  ProfileBehavior.swift
//  Frisbee
//
//  Created by Jordan Kay on 2/13/18.
//  Copyright © 2018 Cultivr. All rights reserved.
//

public extension Profile {
    struct Behavior {
        public let id: Int
        public let primaryBehavior: Frisbee.Behavior
        public let secondaryBehavior: Frisbee.Behavior?
        public let keywords: String
        public let group: Group
        public let contents: [Content]?
    }
}

extension Profile.Behavior: Decodable {
    public static func decode(_ json: Any) throws -> Profile.Behavior {
        return try Profile.Behavior(
            id: json => "data" => "id",
            primaryName: json => "data" => "attributes" => "primary_trait",
            primaryColorName: json => "data" => "attributes" => "primary_color",
            primaryRepresentationName: json => "data" => "attributes" => "primary_name",
            primaryRepresentationImageName: json => "data" => "attributes" => "primary_image",
            secondaryName: json => "data" => "attributes" => "secondary_trait",
            secondaryColorName: json => "data" => "attributes" => "secondary_color",
            secondaryRepresentationName: json => "data" => "attributes" => "secondary_name",
            secondaryRepresentationImageName: json => "data" => "attributes" => "secondary_image",
            keywords: json => "data" => "attributes" => "keywords",
            groupName: json => "data" => "attributes" => "group_type",
            contents: json =>? "included"
        )
    }
}

extension Profile.Behavior: Sqlable {
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
            groupName: row.get(Profile.Behavior.groupName),
            contents: nil
        )
    }
    
    public func valueForColumn(_ column: Column) -> SqlValue? {
        switch column {
        case Profile.Behavior.id: return id
        case Profile.Behavior.primaryName: return primaryBehavior.trait.name
        case Profile.Behavior.primaryColorName: return primaryBehavior.color.name
        case Profile.Behavior.primaryRepresentationName: return primaryBehavior.representation.name
        case Profile.Behavior.primaryRepresentationImageName: return primaryBehavior.representation.image.name
        case Profile.Behavior.secondaryName: return secondaryBehavior?.trait.name
        case Profile.Behavior.secondaryColorName: return secondaryBehavior?.color.name
        case Profile.Behavior.secondaryRepresentationName: return secondaryBehavior?.representation.name
        case Profile.Behavior.secondaryRepresentationImageName: return secondaryBehavior?.representation.image.name
        case Profile.Behavior.keywords: return keywords
        case Profile.Behavior.groupName: return group.name
        default: return nil
        }
    }
}

private extension Profile.Behavior {
    init(id: Int, primaryName: String, primaryColorName: String, primaryRepresentationName: String, primaryRepresentationImageName: String, secondaryName: String?, secondaryColorName: String?, secondaryRepresentationName: String?, secondaryRepresentationImageName: String?, keywords: String, groupName: String, contents: [Content]?) {
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
            ),
            contents: contents
        )
    }
}
