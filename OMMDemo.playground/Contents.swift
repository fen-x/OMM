//: # OMM
//:
//: OMM is a **o**ne **m**ore **m**apper that helps to map JSON objects to Swift instances
//:

import OMM

//: ## Mappable Class
//: There is an exmaple of how to make `Mappable` class below.

class Tweet: Mappable {
//: Unfortunately, Swift does not allow to throw error from initializer before all stored properties of a class instance initialized. That is why constatnt properties with non-optional type are not suitable.
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

//: Provide initilizer that takes `NodeType`. `NodeType` is the protocol that represents any JSON.
    required
    init(node: NodeType) throws {
//: Use subscript syntax to access JSON object properties and array elements. Feel free to apply a number of keys one by one and use both string and integer literals.
//:
//: Use `optional` property to get something that could be `null` or undefined safetly. Use `required` property to get non-optional result or error. Actually, `required` returns the same node and it is ok to skip it. It only exists to make clear intent.
//:
//: Use one of the `value(_:)` methods to get scalar value (number, string or boolean) or `Mappable` instance.
//:
//: Use the `value(transformedWith:)` method to to get instance of any other type. There are a number of predefined transforms: `Int64Transform`, `DateTransform`, etc. It is also possible to define custom transform.
//:
//: Use the `array()` method to get an array of nodes.
//:
//: Use one of the `array(_:)` convenience methods to get an array of converted instances.
//:
//: Use the `dictionary()` method to get a string to node dictionary.
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

//: ## Mappable Structure
//: It is also possible to make `Mappable` structure. Structure allows to use non-optional constant properties.

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

//: ## Transform
//: Transform is another way to make reusable code converting JSON to instance of some type whether it is `Mappable` or not. There are a number of inbuilt transforms such as `URLTransform` and defining custom transforms is pretty simple.

struct RangeTransform: TransformType {

//: One method to convert JSON represented with `NodeType` instance to instance of any other type.
    func applyToNode(node: NodeType) throws -> NSRange {
        let indices = try node.array(Int)
        guard indices.count == 2 else {
//: Throw error to fail transform.
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
//: Same way to apply custom transform as for inbuilt transforms.
        range = try node["indices"].required.value(transformedWith: RangeTransform())
    }

}

//: ## Mappable Types Subclassing
//: Nothing new here, just create subclass and do not forget to call superclass initializer.

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

//: ## In Action
//:
//: Use one of following functions to get node:
//: 1. `NodeForObject(_:)`
//: 1. `NodeForJSONObjectWithData(_:)`
//:
//: _Tweet JSON has been taken from the official Twitter documentation ([GET statuses/show/:id](https://dev.twitter.com/rest/reference/get/statuses/show/:id))._

let path = NSBundle.mainBundle().pathForResource("210462857140252672", ofType: "json")!
let data = NSData(contentsOfFile: path)!
let node = NodeForJSONObjectWithData(data)

do {
//: Convert JSON to the object of expected type.
    let tweet = try node.value(Tweet)

} catch {
//: All methods throw error of `MappingError` type. There are `underlyingError` tells what exactly is wrong and `path` from the root object to problem JSON.
    error

}

