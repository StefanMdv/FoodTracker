import SwiftUI

@main
struct FoodTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            TabHost()
                .preferredColorScheme(.light)
        }
    }
}
