//: # OMM

import OMM

class Tweet: Mappable {

    private(set)
    var id: Int64!

    private(set)
    var user: User!

    private(set)
    var created: NSDate!

    private(set)
    var retweetedStatus: Tweet?

    private(set)
    var text: String!

    private(set)
    var URLs: [URLEntity]!

    private(set)
    var hashtags: [HashtagEntity]!

    private(set)
    var userMentions: [UserMentionEntity]!

    private(set)
    var media: [MediaEntity]!

    private(set)
    var retweetCount: Int!

    private(set)
    var favoriteCount: Int!

    required
    init(node: NodeType) throws {
        id = try node["id"].required.value(transformedWith: Int64Transform)
        user = try node["user"].required.value(User)
        created = try node["created_at"].required.value(transformedWith: DateTransform(dateFormat: "eee MMM dd HH:mm:ss ZZZZ yyyy"))
        retweetedStatus = try node["retweeted_status"].optional?.value(Tweet)
        text = try node["text"].required.value(String)
        URLs = try node["entities", "urls"].optional?.array(URLEntity) ?? []
        hashtags = try node["entities", "hashtags"].optional?.array(HashtagEntity) ?? []
        userMentions = try node["entities", "user_mentions"].optional?.array(UserMentionEntity) ?? []
        media = try node["entities", "media"].optional?.array(MediaEntity) ?? []
        retweetCount = try node["retweet_count"].optional?.value(Int) ?? 0
        favoriteCount = try node["favorite_count"].optional?.value(Int) ?? 0
    }

}

struct User: Mappable {
    let name: String
    let screenName: String

    let profileImageURL: NSURL

    let description: String?
    let descriptionURLs: [URLEntity]

    init(node: NodeType) throws {
        name = try node["name"].required.value(String)
        screenName = try node["screen_name"].required.value(String)
        profileImageURL = try node["profile_image_url"].required.value(transformedWith: URLTransform())
        description = try node["description"].optional?.value(String)
        descriptionURLs = try node["entities", "description", "urls"].optional?.array(URLEntity) ?? []
    }
}

struct RangeTransform: TransformType {

    func applyToNode(node: NodeType) throws -> NSRange {
        let indices = try node.array(Int)
        guard indices.count == 2 else {
            throw errorWithReason("Range requires 2 indices")
        }
        return NSRange(location: indices[0], length: indices[1])
    }

}

class Entity: Mappable {

    private(set)
    var range: NSRange!

    required
    init(node: NodeType) throws {
        range = try node["indices"].required.value(transformedWith: RangeTransform())
    }

}

class HashtagEntity: Entity {

    private(set)
    var text: String!

    required
    init(node: NodeType) throws {
        try super.init(node: node)
        text = try node["text"].required.value(String)
    }

}

class UserMentionEntity: Entity {

    private(set)
    var screenName: String!

    required
    init(node: NodeType) throws {
        try super.init(node: node)
        screenName = try node["screen_name"].required.value(String)
    }

}

class URLEntity: Entity {

    private(set)
    var URL: NSURL!

    private(set)
    var displayURL: String!

    required
    init(node: NodeType) throws {
        try super.init(node: node)
        URL = try node["url"].required.value(transformedWith: URLTransform())
        displayURL = try node["display_url"].required.value(String)
    }

}

class MediaEntity: URLEntity {

    private(set)
    var size: (width: Int, height: Int)!

    required
    init(node: NodeType) throws {
        try super.init(node: node)
        size = try (
            width: node["sizes", "large", "w"].required.value(Int),
            height: node["sizes", "large", "h"].required.value(Int)
        )
    }
    
}

/*:
## In action

_Tweet JSON has been taken from the official Twitter documentation ([GET statuses/show/:id](https://dev.twitter.com/rest/reference/get/statuses/show/:id))._
*/
let path = NSBundle.mainBundle().pathForResource("210462857140252672", ofType: "json")!
let data = NSData(contentsOfFile: path)!
let node = NodeForJSONObjectWithData(data)

do {

    let tweet = try node.value(Tweet)

} catch {

    error

}
