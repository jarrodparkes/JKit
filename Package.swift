// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "JKit",
    platforms: [.iOS(.v12)],
    products: [.library(name: "JKit", targets: ["JKit"])],
    dependencies: [
        .package(name: "HorizonCalendar", url: "https://github.com/airbnb/HorizonCalendar.git", .exact("1.2.0")),
    ],
    targets: [
        .target(name: "JKit", dependencies: ["HorizonCalendar"], resources: [.process("Resources")]),
        .testTarget(name: "JKitTests", dependencies: ["JKit"])
    ],
    swiftLanguageVersions: [.v5]
)
