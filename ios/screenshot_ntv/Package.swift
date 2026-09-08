// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "screenshot_ntv",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(
            name: "screenshot-ntv",
            targets: ["screenshot_ntv"]
        )
    ],
    targets: [
        .target(
            name: "screenshot_ntv",
            cSettings: [
                .headerSearchPath("include/screenshot_ntv")
            ]
        )
    ]
)