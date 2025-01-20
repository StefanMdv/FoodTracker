import SwiftUI

struct DashboardDetails: View {
    @Binding var dailyIntake: DailyIntake
    @Binding var dailyCalTarget: Int
    @Binding var user: User

    @State private var dailyProteinTarget: Int = 0
    @State private var dailyFatTarget: Int = 0
    @State private var dailyCarbsTarget: Int = 0
    @State private var dailyWaterTarget: Int = 0

    @State private var progress = 0.6

    @State private var minCal = 0
    var body: some View {
        VStack {
            DashboardDetailsProgress(
                title: "Kalorien", current: dailyIntake.calories,
                target: dailyCalTarget,
                unit: "kcal")

            DashboardDetailsProgress(
                title: "Proteine", current: dailyIntake.protein ?? 0,
                target: dailyProteinTarget,
                unit: "g")

            DashboardDetailsProgress(
                title: "Fett", current: dailyIntake.fat ?? 0,
                target: dailyFatTarget,
                unit: "g")

            DashboardDetailsProgress(
                title: "Kohlenhydrate", current: dailyIntake.carbs ?? 0,
                target: dailyCarbsTarget,
                unit: "g")

            DashboardDetailsProgress(
                title: "Wasser", current: dailyIntake.water ?? 0,
                target: dailyWaterTarget,
                unit: "ml")
        }
        .padding()
        .onAppear {
            loadUserData()
        }

        .navigationTitle("Dein Fortschritt")
    }

    private func loadUserData() {
        dailyProteinTarget = user.dailyProteinTarget
        dailyFatTarget = user.dailyFatTarget
        dailyCarbsTarget = user.dailyCarbsTarget
        dailyWaterTarget = user.dailyWaterTarget
    }
}
