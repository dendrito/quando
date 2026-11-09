// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "alarm",
    platforms: [.macOS("12.0")],
    products: [.library(name: "alarm", targets: ["alarm"])],
    dependencies: [.package(name: "FlutterFramework", path: "../FlutterFramework")],
    targets: [.target(name: "alarm", dependencies: [
        .product(name: "FlutterFramework", package: "FlutterFramework"),
    ])]
)
