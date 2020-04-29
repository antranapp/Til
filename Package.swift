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
        .package(url: "https://github.com/apple/swift-argument-parser",from: "0.0.5"),
        .package(url: "https://github.com/mtynior/ColorizeSwift", from: "1.5.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.1.1"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "3.0.0"),
        .package(url: "https://github.com/JohnSundell/ShellOut", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "Til",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Yams",
                "ColorizeSwift",
                "Files",
                "ShellOut"
            ],
            path: "."),
    ]
)
