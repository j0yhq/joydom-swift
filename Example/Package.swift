// swift-tools-version: 5.9
import PackageDescription

// Runnable example for the JoyDOM binary package. From a clone of this repo:
//
//   cd Example && swift run JoyDOMShowcase
//
// It depends on the parent package by path, so it renders against the exact
// JoyDOM/FlexLayout XCFrameworks this release pins. The smallest end-to-end
// JoyDOM app: one inline JSON document, the built-in primitives + one custom
// `badge` component, and a single `.onEvent` handler.
let package = Package(
    name: "JoyDOMShowcase",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    dependencies: [
        .package(path: ".."),
    ],
    targets: [
        .executableTarget(
            name: "JoyDOMShowcase",
            dependencies: [.product(name: "JoyDOM", package: "joydom-swift")],
            path: "Sources/JoyDOMShowcase"
        ),
    ]
)
