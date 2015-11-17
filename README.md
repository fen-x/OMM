# OMM [![GitHub MIT License](https://img.shields.io/github/license/fen-x/OMM.svg)](https://raw.githubusercontent.com/fen-x/OMM/master/LICENSE) [![GitHub Release](https://img.shields.io/github/release/fen-x/OMM.svg)](https://github.com/fen-x/OMM/releases) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)

OMM is a **o**ne **m**ore **m**apper that helps to map JSON objects to Swift instances.

* [Features](#features)
* [Quick Start](#quick-start)
* [License](#license)
* [Installation](#installation)

## Features

Firstly, OMM provides only one-way conversion from JSON.
For both to and from conversions try something else like [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON), [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) or whatever.

OMM does not extend any standard types. It allows to keep clear compact API.

OMM supports Swift error handling.

OMM provides subscript syntax to get values from both objects and arrays.

OMM allows to to distinguish absence of value and wrong value.

OMM gives opportunity to reuse mapping uging mappable types and custom transforms.

## Quick Start

### Initialization

```swift
import OMM

let binaryDataNode = NodeForJSONObjectWithData(someNSData)
let anyObjectNode = NodeForObject(anyObject)
```

### Subscript

```swift
let nodeForArrayElement = node[42]
let nodeForPopertyValue = node["propertyName"]
let nodeForMixedPath = node["property", "anotherProperty", 0]
```

### Materialization

```swift
let intValue = try node.value(Int)
let arrayOfStrings = try node.array(String)
```

### Error handling

```swift
do {
	let intValue = try node.value(Int)
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
	let intValue = try node.optional?.value(Int)
	// intValue contains optional integer value
} catch {
	// Value is not number
}

let stringValue = try? node.value(String)
// stringValue contains optional string value anyway
```

### Transforms

```swift
let URLValue = try node.value(transformedWith: URLTransform())

struct LengthTransform: TransformType {
	func applyToNode(node: NodeType) throws -> Double {
		let value = try node.value(Double)
		if value < 0 {
			throw errorWithReason("Length should be non-negative")
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

	init(node: NodeType) throws {
		identifier = try node["user_id"].required.value(transformedWith: Int64Transform)
		name = try node["user_name"].optional?.value(String) ?? ""
	}
}
let user = try node.value(User)
```

## License

OMM is released under the [MIT License](https://raw.githubusercontent.com/fen-x/OMM/master/LICENSE).

## Installation

* Using [Carthage](https://github.com/Carthage/Carthage)
```
github "fen-x/OMM"
```
* Using [Git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
