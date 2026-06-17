# JoyDOM (Swift)

Native SwiftUI rendering of a JSON spec — a subset of HTML/CSS — for Apple
platforms. Distributed as **precompiled XCFrameworks**; source is not included.

## Requirements

- iOS 16+ / macOS 13+
- Xcode 16+ (Swift 5.9+)

## Installation (Swift Package Manager)

**Xcode:** File → Add Package Dependencies → `https://github.com/j0yhq/joydom-swift`
→ Dependency Rule **Exact Version** `0.0.4-alpha`.

**Package.swift:**

```swift
dependencies: [
    .package(url: "https://github.com/j0yhq/joydom-swift", exact: "0.0.4-alpha"),
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "JoyDOM", package: "joydom-swift"),
    ]),
]
```

The single `JoyDOM` product links both the renderer and its FlexLayout engine.

> **Alpha (`0.0.4-alpha`)** — prerelease. Pin with `exact:`; the API may change.
> See [Releases](https://github.com/j0yhq/joydom-swift/releases) for the latest.

## Usage

```swift
import SwiftUI
import JoyDOM

struct ContentView: View {
    let spec: Spec   // try JSONDecoder().decode(Spec.self, from: jsonData)

    // Seed the built-in primitives (div / p / h1–h6 / span / img, and the
    // other built-in HTML element types).
    private let registry = ComponentRegistry().withDefaultPrimitives()

    var body: some View {
        JoyDom(spec: spec, components: registry)
            .viewport(Viewport(width: 360))   // drives breakpoint resolution
            .onEvent { event in               // one handler for every binding/emit
                print("event:", event.name)
            }
    }
}
```

`JoyDom(spec:components:)` is the entry-point view; `Viewport`,
`ComponentRegistry`, custom-component registration, and `.onEvent` are covered in
the API reference: <https://j0yhq.github.io/joy-dom/swift-api/documentation/joydom>.

## Example

A runnable, single-file showcase lives in [`Example/`](Example) — one inline JSON
document, the built-in primitives plus a custom `badge` component, and an
`.onEvent` handler that updates state on each tap:

```sh
git clone https://github.com/j0yhq/joydom-swift.git
cd joydom-swift/Example
swift run JoyDOMShowcase
```

It depends on this package by path, so it renders against the exact `JoyDOM` /
`FlexLayout` XCFrameworks this checkout pins.
