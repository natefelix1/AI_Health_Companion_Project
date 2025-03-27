# VitAl Health Companion

VitAl (formerly AI Health Companion) is a health-focused iOS and watchOS application that provides personalized health insights and proactive recommendations.

## Project Organization

This project has been reorganized with the following structure:

```
VitAl/
├── VitAl/                # iOS App
│   ├── Models/           # Data models
│   ├── Views/            # SwiftUI views
│   │   └── iOS/          # iOS-specific views
│   ├── ViewModels/       # View models
│   ├── Services/         # Service layer
│   └── Utilities/        # Helper utilities
├── VitAl Watch/          # watchOS companion app
├── VitAl Watch Watch App/ # watchOS app
├── VitAlTests/           # iOS unit tests
├── VitAlUITests/         # iOS UI tests
└── Documentation/        # Project documentation
```

## Renaming Changes

The project has been renamed from "AI Health Companion" to "VitAl" with the following key changes:

1. Updated app structure names (AIHealthCompanionApp → VitAlApp)
2. Updated file references in the Xcode project
3. Renamed entitlement files and Info.plist references
4. Updated UI text references

## Next Steps

1. Open the VitAl.xcodeproj file in Xcode
2. Verify that all file references are correct
3. Run a clean build to ensure everything is working properly
