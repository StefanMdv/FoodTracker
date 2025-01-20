import SwiftUI

struct WaterView: View {
    @State private var currentDay: Date = Date()
    @State private var isAddWaterEntryOpened: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""

    @Binding var trackerEntries: [Entry]
    @Binding var waterEntries: [Water]
    @Binding var dailyWaterTarget: Int

    var body: some View {
        NavigationStack {
            List {
                ForEach($waterEntries) { $waterEntry in
                    Section(
                        header: Text(
                            String(
                                waterEntry.date.formatted(
                                    date: Date.FormatStyle.DateStyle.numeric,
                                    time: Date.FormatStyle.TimeStyle.omitted)))
                    ) {
                        WaterDetailView(
                            waterEntry: $waterEntry,
                            dailyWaterTarget: $dailyWaterTarget, date: $waterEntry.date)
                    }
                }.navigationTitle("Wasser")
                    .navigationBarTitleDisplayMode(.large)

            }.toolbar {
                Button {
                    isAddWaterEntryOpened = true
                } label: {
                    Image(systemName: "plus.square.fill.on.square.fill")
                }
                .sheet(isPresented: $isAddWaterEntryOpened) {
                    AddWaterView(
                        showErrorAlert: $showErrorAlert,
                        errorMessage: $errorMessage,
                        addWaterEntry: addWaterEntry
                    )
                }
            }
        }
    }

    func addWaterEntry(newEntry: Water) {
        let existingEntry = waterEntries.first { entry in
            Calendar.current.isDate(entry.date, inSameDayAs: newEntry.date)
        }
        if existingEntry != nil {
            errorMessage = "Für heute existiert bereits eine Wassereingabe"
            showErrorAlert = true
        } else {
            waterEntries.append(newEntry)
        }
    }
}
