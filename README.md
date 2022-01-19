# Bugsee extensions for SwiftUI

## SwiftUI App Lifecycle

If your app adopts the SwiftUI App Life Cycle, the simplest approach is to launch Bugsee within the App conformer’s initializer:

```swift
import Bugsee
import SwiftUI

@main
struct BugseeSwiftUIApp: App {
    init() {
        let options : [String: Any] =
            [ BugseeMaxRecordingTimeKey   : 60,
              BugseeShakeToReportKey      : false,
              BugseeScreenshotToReportKey : true,
              BugseeCrashReportKey        : true ]

        Bugsee.launch(token: "<your_app_token>", options: options)
    }
}
```

## Protecting views

All system secure fields ([SecureField](https://developer.apple.com/documentation/swiftui/securefield)) are hidden from the recorded video automatically. In addition we support a way to mark your custom sensitive views so they will be treated similarly. We provide View extension for this ([View+Bugsee.swift](https://github.com/bugsee/bugsee-swiftui)) which contains _bugseeProtect(completion:)_ method.

```swift
    Text("HelloWorld")
        .bugseeProtect { view in
            // The usual way
            // Mark provided view as bugseeProtectedView
            view.bugseeProtectedView = true
        }
```
