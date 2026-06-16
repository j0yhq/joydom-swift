# JoyDOM (Swift)

Native SwiftUI rendering of a JSON spec — a subset of HTML/CSS — for Apple
platforms. Distributed as **precompiled XCFrameworks**; source is not included.

## Requirements

- iOS 16+ / macOS 13+
- Xcode 16+ (Swift 5.9+)

## Installation (Swift Package Manager)

**Xcode:** File → Add Package Dependencies → `https://github.com/j0yhq/joydom-swift`

**Package.swift:**

```swift
dependencies: [
    .package(url: "https://github.com/j0yhq/joydom-swift", exact: "0.0.1-alpha"),
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "JoyDOM", package: "joydom-swift"),
    ]),
]
```

The single `JoyDOM` product links both the renderer and its FlexLayout engine.

> **Alpha (0.0.1-alpha)** — prerelease. Pin with `exact:`; the API may change.

## Usage

```swift
import SwiftUI
import JoyDOM

struct ContentView: View {
    let spec: Spec   // decode from JSON: try JSONDecoder().decode(Spec.self, from: data)

    var body: some View {
        JoyDOMView(spec: spec)
            .onEvent("submit") { event in
                print("event:", event.name, event.payload)
            }
    }
}
```
