// swift-tools-version: 5.9
import PackageDescription

// JoyDOM — public binary distribution. Precompiled, source-hidden XCFrameworks.
// The single `JoyDOM` product vends the renderer and its FlexLayout engine.
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
            url: "https://github.com/j0yhq/joydom-swift/releases/download/0.0.4-alpha/JoyDOM.xcframework.zip",
            checksum: "091111f7625edcb381cf05841b72e265630e3f58e723da5120314c5fb1fba629"
        ),
        .binaryTarget(
            name: "FlexLayout",
            url: "https://github.com/j0yhq/joydom-swift/releases/download/0.0.4-alpha/FlexLayout.xcframework.zip",
            checksum: "50366167d308a523e2471c0186e5bf8a1bb8184bcc6302ada4e67c871b4b7eaf"
        ),
    ]
)
