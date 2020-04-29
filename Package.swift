// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Til",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .executable(name: "Til", targets: ["Til"])
    ],
    dependencies: [
        .package(name: "SwiftPM", url: "https://github.com/apple/swift-package-manager", from: "0.5.0"),
        .package(url: "https://github.com/apple/swift-argument-parser",from: "0.0.5"),
        .package(url: "https://github.com/mtynior/ColorizeSwift", from: "1.5.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.1.1")
    ],
    targets: [
        .target(
            name: "Til",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "SwiftPM",
                "ColorizeSwift",
                "Files"
            ],
            path: "."),
    ]
)
