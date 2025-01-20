import SwiftUI

struct DailyTargetView: View {
    @Binding var dailyCalTarget: Int
    @Binding var dailyProteinTarget: Int
    @Binding var dailyFatTarget: Int
    @Binding var dailyCarbsTarget: Int
    @Binding var dailyWaterTarget: Int
    @Binding var user: User

    @State private var showEditSheet = false

    let proteinCaloriesPerGram = 4
    let fatCaloriesPerGram = 9
    let carbsCaloriesPerGram = 4

    var proteinCalories: Double {
        return Double(dailyProteinTarget) * Double(proteinCaloriesPerGram)
    }

    var fatCalories: Double {
        return Double(dailyFatTarget) * Double(fatCaloriesPerGram)
    }

    var carbsCalories: Double {
        return Double(dailyCarbsTarget) * Double(carbsCaloriesPerGram)
    }

    var totalCalories: Double {
        return Double(dailyCalTarget)
    }

    var proteinPercentage: Int {
        let percentage = (proteinCalories / totalCalories) * 100
        return roundPercentage(percentage)
    }

    var fatPercentage: Int {
        let percentage = (fatCalories / totalCalories) * 100
        return roundPercentage(percentage)
    }

    var carbsPercentage: Int {
        let percentage = (carbsCalories / totalCalories) * 100
        return roundPercentage(percentage)
    }

    private func roundPercentage(_ value: Double) -> Int {
        let roundedValue = Int(value.rounded())
        return min(100, roundedValue)
    }

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Ernährung")) {

                    HStack {
                        Text("Kalorien")
                        Spacer()
                        Text("\(dailyCalTarget) kcal")
                            .foregroundColor(.blue)
                    }

                    HStack {
                        Text("Kohlenhydrate")
                        Text("\(dailyCarbsTarget) g")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(carbsPercentage)%")
                            .foregroundColor(.blue)
                    }

                    HStack {
                        Text("Protein")
                        Text("\(dailyProteinTarget) g")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(proteinPercentage)%")
                            .foregroundColor(.blue)
                    }

                    HStack {
                        Text("Fett")
                        Text("\(dailyFatTarget) g")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(fatPercentage)%")
                            .foregroundColor(.blue)
                    }
                }
                
                Section(header: Text("Wasser")){
                    HStack{
                        Text("Wasser")
                        Spacer()
                        Text("\(dailyWaterTarget) ml")
                            .foregroundColor(.blue)
                    }
                }

                Button("Bearbeiten") {
                    showEditSheet.toggle()
                }
                .sheet(isPresented: $showEditSheet) {
                    DailyTargetEdit(
                        dailyCalTarget: $dailyCalTarget,
                        dailyProteinTarget: $dailyProteinTarget,
                        dailyFatTarget: $dailyFatTarget,
                        dailyCarbsTarget: $dailyCarbsTarget, dailyWaterTarget: $dailyWaterTarget, user: $user,
                        proteinPercent: Double(proteinPercentage),
                        fatPercent: Double(fatPercentage),
                        carbsPercent: Double(carbsPercentage))
                }
            }
        }
        .navigationTitle("Deine Ziele")
    }
}
