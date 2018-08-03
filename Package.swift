// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "FirestoreDocument",
    products: [
        .library(name: "FirestoreDocument", targets: ["FirestoreDocument"])
    ],
    targets: [
        .target(
            name: "FirestoreDocument",
            path: "FirestoreDocument"
        ),
        .testTarget(
            name: "FirestoreDocumentTests",
            dependencies: ["FirestoreDocument"],
            path: "FirestoreDocumentTests"
        )
    ]
)
