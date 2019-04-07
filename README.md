# OMM [![GitHub MIT License](https://img.shields.io/github/license/fen-x/OMM.svg)](https://raw.githubusercontent.com/fen-x/OMM/master/LICENSE) [![GitHub Release](https://img.shields.io/github/release/fen-x/OMM.svg)](https://github.com/fen-x/OMM/releases) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage) [![CocoaPods Version](https://img.shields.io/cocoapods/v/OMM.svg)](https://cocoapods.org/pods/OMM) [![CocoaPods License](https://img.shields.io/cocoapods/l/OMM.svg)](http://opensource.org/licenses/MIT) [![CocoaPods Platform](https://img.shields.io/cocoapods/p/OMM.svg)]()

OMM is a **o**ne **m**ore **m**apper that helps to map JSON and property list objects to Swift instances.

* [Features](#features)
* [Quick Start](#quick-start)
* [License](#license)
* [Installation](#installation)

## Features

Firstly, OMM provides only one-way conversion from JSON.
For both to and from conversions try something else like [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON), [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) or whatever.

OMM also provides one-way conversion from property list.

OMM does not extend any standard types. It allows to keep clear compact API.

OMM supports Swift error handling.

OMM provides subscript syntax to get values from both objects and arrays.

OMM allows to distinguish absence of value and wrong value.

OMM gives opportunity to reuse mapping using mappable types and custom transforms.

## Quick Start

### Initialization

```swift
import OMM

let jsonDataNode = makeNode(forJSON: someData)
let propertyListDataNode = makeNode(forPropertyList: anotherData)
let anyObjectNode = makeNode(for: anyObject)
```

### Subscript

```swift
let nodeForArrayElement = node[42]
let nodeForPopertyValue = node["propertyName"]
let nodeForMixedPath = node["property", "anotherProperty", 0]
```

### Materialization

```swift
let intValue = try node.value(Int.self)
let arrayOfStrings = try node.array(String.self)
```

### Error handling

```swift
do {
    let intValue: Int = try node.value()
    // intValue contains non-optional integer value
} catch let error as MappingError {
    // There is no value or value is not number
} catch {
    // Actually, never happens
}
```

### Optionals

```swift
do {
    let intValue = try node.optional?.value(Int.self)
    // intValue contains optional integer value
} catch {
    // Value is not number
}

let stringValue = try? node.value(String.self)
// stringValue contains optional string value anyway
```

### Transforms

```swift
let urlValue = try node.value(transformedWith: URLTransform())

struct LengthTransform: Transform {
    func apply(to node: Node) throws -> Double {
        let value = try node.value(Double.self)
        if value < 0 {
            throw error(reason: "Length should be non-negative")
        }
        return value
    }
}
let length = try node.value(transformedWith: LengthTransform())
```

### Mappable types

```swift
struct User: Mappable {
    let identifier: Int64
    let name: String

    init(node: Node) throws {
        identifier = try node["user_id"].required.value(transformedWith: Int64Transform)
        name = try node["user_name"].optional?.value(String.self) ?? ""
    }
}
let user = try node.value(User)
```

## License

OMM is released under the [MIT License](https://raw.githubusercontent.com/fen-x/OMM/master/LICENSE).

## Installation

* Using [CocoaPods](https://cocoapods.org)

```ruby
pod 'OMM'

# to get property list support as well
pod 'OMM/PropertyList'
```

* Using [Carthage](https://github.com/Carthage/Carthage)

```
github "fen-x/OMM"
```

  1. Use `OMM4JSON.framework` for JSON only support.
  1. Use `OMM4PropertyList.framework` for property list support.
  1. Use `OMM.framework` for both JSON and property list support.

Do not forget to use appropriate module name for import declaration: `OMM4JSON`, `OMM4PropertyList`, and `OMM`, respectively.

* Using [Git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
