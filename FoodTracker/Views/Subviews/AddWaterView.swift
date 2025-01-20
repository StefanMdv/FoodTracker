import SwiftUI

struct AddWaterView: View {
    @State private var water: String = ""

    @Binding var showErrorAlert: Bool
    @Binding var errorMessage: String

    let addWaterEntry: (Water) -> Void
    var canSubmit: Bool {
        return !water.isEmpty
    }
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Wasser hinzufügen:") {
                    TextField("Wasser - ml", text: $water)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Wasser hinzufügen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Abbrechen")
                    }
                    .tint(.red)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if let waterAmount = Int(water) {
                            addWaterEntry(
                                Water(quantity: waterAmount, date: Date()))
                        }
                        if !showErrorAlert {
                            dismiss()
                        }
                    } label: {
                        Text("Hinzufügen")
                    }
                    .disabled(!canSubmit)
                }
                
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Fehler"), message: Text(errorMessage),
                dismissButton: .default(Text("OK")){
                    dismiss()
                })
        }
    }
}
