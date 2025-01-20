import SwiftUI

struct AddEntryView: View {
    @State private var title: String = ""
    @State private var calories: String = ""
    @State private var protein: String = ""
    @State private var fat: String = ""
    @State private var carbs: String = ""
    @State private var addNutritionalValue = false

    @Binding var date: Date
    
    let addEntry: (Entry) -> Void
    let type: EntryType
    var canSubmit: Bool {
        if addNutritionalValue {
            return !title.isEmpty && !calories.isEmpty && !protein.isEmpty && !fat.isEmpty && !carbs.isEmpty
        } else {
            return !title.isEmpty && !calories.isEmpty
        }
    }
    
    private var navTitle: String {
        switch type {
        case .snacks:
            return "+ Snack"
        case .drinks:
            return "+ Getränk"
        default:
            return "+ Nahrungsmittel"
        }
    }
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Details")) {
                        TextField("Nahrungsmittel :", text: $title)
                        TextField("Kalorien :", text: $calories)
                            .keyboardType(.numberPad)
                            .onChange(of: calories) { oldValue, newValue in
                                calories = newValue.filter { $0.isNumber }
                            }
                    }.padding(4)

                    Section {
                        Toggle(
                            "Nährwerte hinzufügen", isOn: $addNutritionalValue)
                        if addNutritionalValue {
                            TextField("Eiweis :", text: $protein)
                                .keyboardType(.numberPad)
                                .onChange(of: protein) { oldValue, newValue in
                                    protein = newValue.filter { $0.isNumber }
                                }
                            TextField("Fett :", text: $fat)
                                .keyboardType(.numberPad)
                                .onChange(of: fat) { oldValue, newValue in
                                    fat = newValue.filter { $0.isNumber }
                                }
                            TextField("Kohlenhydrate :", text: $carbs)
                                .keyboardType(.numberPad)
                                .onChange(of: carbs) { oldValue, newValue in
                                    carbs = newValue.filter { $0.isNumber }
                                }
                        }
                    }
                }
                .navigationTitle(navTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Abbrechen")
                        }.tint(.red)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            addEntry(
                                Entry(
                                    title: title, date: date,
                                    calories: Int(calories) ?? 0, type: type,
                                    protein: Int(protein) ?? 0,
                                    fat: Int(fat) ?? 0, carbs: Int(carbs) ?? 0))
                            dismiss()
                        } label: {
                            Text("Hinzufügen")
                        }.disabled(!canSubmit)
                    }
                }
            }.padding(.vertical)
                .background(.listBg)
        }
    }
}

#Preview {
    AddEntryView(
        date: .constant(Date()),
        addEntry: {
            _ in
        }, type: .breakfast)
}
