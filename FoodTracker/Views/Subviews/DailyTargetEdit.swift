import SwiftUI

struct DailyTargetEdit: View {
    @Binding var dailyCalTarget: Int
    @Binding var dailyProteinTarget: Int
    @Binding var dailyFatTarget: Int
    @Binding var dailyCarbsTarget: Int
    @Binding var dailyWaterTarget: Int
    @Binding var user: User

    @State private var fatPercentage: Double = 0
    @State private var carbsPercentage: Double = 0
    @State private var proteinPercentage: Double = 0
    @State private var isAddingEnabled: Bool = false

    var proteinPercent: Double
    var fatPercent: Double
    var carbsPercent: Double

    @Environment(\.dismiss) private var dismiss

    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimum = 0
        formatter.maximum = 10000
        return formatter
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Tägliche Kalorien (kcal)")) {
                    TextField(
                        "Kalorien", value: $dailyCalTarget, formatter: formatter
                    )
                    .keyboardType(.numberPad)
                    .onChange(of: dailyCalTarget) {
                        validateForm()
                        recalculateTargets()
                    }
                }

                Section(header: Text("Makronährstoffe (% der Kalorien)")) {
                    HStack {

                        VStack {
                            Text("Kohlenhydrate")
                            Text(
                                "\(Int((carbsPercentage / 100) * Double(dailyCalTarget) / 4)) g"
                            )
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            Picker("Kohlenhydrate", selection: $carbsPercentage)
                            {
                                ForEach(0..<21, id: \.self) { value in
                                    Text("\(value * 5)%").tag(Double(value * 5))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 120)
                            .onChange(of: carbsPercentage) {
                                validateForm()
                                recalculateTargets()
                            }
                        }

                        VStack {
                            Text("Protein")
                            Text(
                                "\(Int((proteinPercentage / 100) * Double(dailyCalTarget) / 4)) g"
                            )
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            Picker("Protein", selection: $proteinPercentage) {
                                ForEach(0..<21, id: \.self) { value in
                                    Text("\(value * 5)%").tag(Double(value * 5))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 120)
                            .onChange(of: proteinPercentage) {
                                validateForm()
                                recalculateTargets()
                            }
                        }

                        VStack {
                            Text("Fett")
                            Text(
                                "\(Int((fatPercentage / 100) * Double(dailyCalTarget) / 9)) g"
                            )
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            Picker("Fett", selection: $fatPercentage) {
                                ForEach(0..<21, id: \.self) { value in
                                    Text("\(value * 5)%").tag(Double(value * 5))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 120)
                            .onChange(of: fatPercentage) {
                                validateForm()
                                recalculateTargets()
                            }
                        }
                    }
                }

                Section(header: Text("Gesamt")) {
                    Text(
                        "% Gesamt: \(Int(fatPercentage) + Int(carbsPercentage) + Int(proteinPercentage))%"
                    )
                    .foregroundColor(sumIsValid() ? .green : .red)
                    Text("Die Makronährstoffe müssen gleich 100% sein")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                Section(header: Text("Wasser (ml)")) {
                    TextField(
                        "Water", value: $dailyWaterTarget, formatter: formatter
                    )
                    .keyboardType(.numberPad)
                    .onChange(of: dailyWaterTarget) {
                        validateForm()
                        recalculateTargets()
                    }
                }

                Section {
                    Button("Abbrechen") {
                        dismiss()
                    }
                    .tint(.red)

                    Button("Speichern") {
                        saveUserData()
                        dismiss()
                    }
                    .disabled(!sumIsValid())
                }
            }
            .navigationTitle("Ziele festlegen")
        }.onAppear {
            loadPercentage()
        }
    }

    func loadPercentage() {
        proteinPercentage = proteinPercent
        fatPercentage = fatPercent
        carbsPercentage = carbsPercent
    }

    private func recalculateTargets() {
        dailyFatTarget = Int((fatPercentage / 100) * Double(dailyCalTarget) / 9)
        dailyCarbsTarget = Int(
            (carbsPercentage / 100) * Double(dailyCalTarget) / 4)
        dailyProteinTarget = Int(
            (proteinPercentage / 100) * Double(dailyCalTarget) / 4)
    }

    private func sumIsValid() -> Bool {
        return fatPercentage + carbsPercentage + proteinPercentage == 100
    }

    private func validateForm() {
        isAddingEnabled = sumIsValid()
    }
    
    private func saveUserData() {
        user.dailyCarbsTarget = Int((carbsPercentage / 100) * Double(dailyCalTarget) / 4)
        user.dailyProteinTarget = Int((proteinPercentage / 100) * Double(dailyCalTarget) / 4)
        user.dailyFatTarget = Int((fatPercentage / 100) * Double(dailyCalTarget) / 9)
        user.dailyCalTarget = dailyCalTarget
        user.dailyWaterTarget = dailyWaterTarget
    }
}
