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
        case Profile.Behavior.primaryName: return primaryBehavior.value.name
        case Profile.Behavior.primaryColorName: return primaryBehavior.color.name
        case Profile.Behavior.primaryRepresentationName: return primaryBehavior.representation.name
        case Profile.Behavior.primaryRepresentationImageName: return primaryBehavior.representation.image.name
        case Profile.Behavior.secondaryName: return secondaryBehavior?.value.name
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
