// swift-tools-version: 5.9
import PackageDescription

// JoyDOM — public binary distribution.
//
// Precompiled, source-hidden XCFrameworks. The `JoyDOM` product vends both the
// JoyDOM renderer and its FlexLayout engine (JoyDOM's public API exposes a few
// FlexLayout types), so depending on the single product is enough.
let package = Package(
    name: "JoyDOM",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(name: "JoyDOM", targets: ["JoyDOM", "FlexLayout"]),
    ],
    targets: [
        .binaryTarget(
            name: "JoyDOM",
            url: "https://github.com/j0yhq/joydom-swift/releases/download/0.0.1-alpha/JoyDOM.xcframework.zip",
            checksum: "b4926a102fe3f1a54dbf1e3e5eb428b246fb09dd69e8a1c620ae7841b74848c6"
        ),
        .binaryTarget(
            name: "FlexLayout",
            url: "https://github.com/j0yhq/joydom-swift/releases/download/0.0.1-alpha/FlexLayout.xcframework.zip",
            checksum: "28f61d2756d87b20d6305d78c9f0984efb561efde3500d0d90cb9d526ec16b4d"
        ),
    ]
)
