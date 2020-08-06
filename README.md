# GoustoExercise

![demo gif](demo.gif)

Please see original requirements in original [pdf](Gousto_iOS_Test.pdf)

## Target environment
- Xcode 11.6 - 12.0b4
- iOS 13.6 and up
- no 3rd party dependencies

## Project highlights
- Swift UI 1
- Dark mode and accessibility support
- Persistence layer for offline product list storage
- Clear separation of concerns
- Dependency injection
- MVVM with reactive subscription interface for UI
- API wrapper around `URLSession` utilising generics
- API consumes `Endpoint` encapsulating strongly-typed request and response
- Unit and UI Tests for core components

### What could be improved given more time
- API error handling in UI
- Search bar is bridged into SwiftUI from UIKit. Lacks hiding keyboard on scrolling
- Search/filtering performance could be improved. This wasn't a goal for this project
- More tests. Everything is made testable, but due to repetetive nature of tests and time constraints, I did not cover API helpers and all possible scenarios
