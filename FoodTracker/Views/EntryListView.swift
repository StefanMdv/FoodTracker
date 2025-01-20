import SwiftUI

struct EntryListView: View {

    @State private var showRemoveAlert: Bool = false
    @State private var showRemoveAllAlert: Bool = false
    @State private var entryToBeDeleted: String = ""
    @State private var isAddEntryOpened: Bool = false
    @State private var selectedEntryType: EntryType = .breakfast
    @State private var minCal = 0
    @State private var currentDay: Date = Date()
    @State private var diaryDay: Date = Date()
    @State private var swipeEdgeOffset: CGFloat = 0

    @Binding var dailyCalIntake: Int
    @Binding var dailyCalTarget: Int
    @Binding var trackerEntries: [Entry]

    var dailyProgress: Int {
        let filteredEntries = trackerEntries.filter { entry in
            let calendar = Calendar.current
            let entryStartOfDay = calendar.startOfDay(
                for: entry.date)
            let currentStartOfDay = calendar.startOfDay(
                for: currentDay)
            return entryStartOfDay == currentStartOfDay
        }
        return filteredEntries.reduce(0) { $0 + $1.calories }
    }

    var currentDayTitle: String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let targetDay = calendar.startOfDay(for: currentDay)

        if targetDay == today {
            return "Heute"
        } else if targetDay == calendar.date(
            byAdding: .day, value: 1, to: today)!
        {
            return "Morgen"
        } else if targetDay == calendar.date(
            byAdding: .day, value: -1, to: today)!
        {
            return "Gestern"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            return dateFormatter.string(from: currentDay)
        }
    }

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button("<") {
                        moveToPreviousDay()
                    }
                    .padding()

                    Text(currentDayTitle)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.blue)
                        .padding(.horizontal, 2)

                    Button(">") {
                        moveToNextDay()
                    }
                    .padding()
                }
                
                VStack {
                    Gauge(
                        value: Double(dailyProgress),
                        in: 0...Double(dailyCalTarget)
                    ) {
                        Text("Kalorien")
                    } currentValueLabel: {
                        Text(dailyProgress.description)
                    } minimumValueLabel: {
                        Text(minCal.description)
                    } maximumValueLabel: {
                        Text(dailyCalTarget.description)
                    }.padding(16)
                        .tint(dailyProgress > dailyCalTarget ? .red : .blue)
                }
            }.gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < 0 {
                            moveToNextDay()
                        } else if value.translation.width > 0 {
                            moveToPreviousDay()
                        }
                    }
            )
            
            HStack {
                Text("Einträge")
                    .font(.title)
                    .bold()
                Spacer()
                Button {
                    showRemoveAllAlert = true
                } label: {
                    Image(systemName: "trash")
                    Text("Alle Löschen")
                }.tint(.red)
            }.padding()
                .background(.listBg)
            List {
                ForEach(EntryType.allCases, id: \.self) { entryType in
                    Section(entryType.rawValue) {
                        let filteredEntries = trackerEntries.filter { entry in
                            let calendar = Calendar.current
                            let entryStartOfDay = calendar.startOfDay(
                                for: entry.date)
                            let currentStartOfDay = calendar.startOfDay(
                                for: currentDay)
                            return entryStartOfDay == currentStartOfDay
                        }

                        let typeEntries = filteredEntries.filter {
                            $0.type == entryType
                        }
                        if typeEntries.isEmpty {
                            NoEntryView()
                        } else {

                            ForEach(typeEntries) { trackerEntry in
                                if trackerEntry.type == entryType {
                                    EntryView(trackerEntry: trackerEntry)
                                        .swipeActions {
                                            Button {
                                                entryToBeDeleted =
                                                    trackerEntry.id
                                                showRemoveAlert = true

                                            } label: {
                                                Label(
                                                    "Delete",
                                                    systemImage: "trash")
                                            }.tint(.red)
                                        }
                                }
                            }

                        }
                        Button {
                            selectedEntryType = entryType
                            isAddEntryOpened = true
                        } label: {
                            Label(
                                entryType == .drinks
                                    ? "Getränk hinzufügen"
                                    : "Nahrungsmittel hinzufügen",
                                systemImage: "plus.app.fill")
                        }
                    }
                }
            }
            .sheet(isPresented: $isAddEntryOpened) {
                AddEntryView(
                    date: $currentDay,
                    addEntry: addEntry, type: selectedEntryType
                )
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.8), .large])
            }.alert(
                "Eintrag wirklich löschen ?",
                isPresented: $showRemoveAlert
            ) {
                Button("Abbrechen", role: .cancel) {}
                Button(
                    "Löschen", role: .destructive
                ) {
                    removeEntry(id: entryToBeDeleted)
                }
            }
            .alert(
                "Alle Einträge wirklich löschen ?",
                isPresented: $showRemoveAllAlert
            ) {
                Button("Abbrechen", role: .cancel) {}
                Button(
                    "Löschen", role: .destructive
                ) {
                    removeAll()
                }
            }
        }.background(.listBg)
    }

    private func removeEntry(id: String) {
        trackerEntries.removeAll(where: { $0.id == id })
    }

    private func addEntry(newEntry: Entry) {
        trackerEntries.append(newEntry)
    }

    private func removeAll() {
        trackerEntries.removeAll()
    }

    private func moveToPreviousDay() {
        currentDay = Calendar.current.date(
            byAdding: .day, value: -1, to: currentDay)!
    }

    private func moveToNextDay() {
        currentDay = Calendar.current.date(
            byAdding: .day, value: 1, to: currentDay)!
    }
}

#Preview {
    EntryListView(
        dailyCalIntake: .constant(2100),
        dailyCalTarget: .constant(2850),
        trackerEntries: .constant([
            Entry(
                title: "Spiegelei mit Speck", date: Date(), calories: 550,
                type: .breakfast),
            Entry(
                title: "Semmel", date: Date(), calories: 150, type: .breakfast),
            Entry(
                title: "Snickers", date: Date(), calories: 350, type: .snacks),
            Entry(title: "Chips", date: Date(), calories: 380, type: .snacks),
            Entry(
                title: "Spaghetti Bolognese", date: Date(), calories: 488,
                type: .lunch),
            Entry(title: "Calamari", date: Date(), calories: 205, type: .lunch),
            Entry(title: "Pommes", date: Date(), calories: 280, type: .lunch),
            Entry(title: "Döner", date: Date(), calories: 550, type: .dinner),
            Entry(
                title: "Latte Macchiato", date: Date(), calories: 75,
                type: .drinks),
            Entry(title: "Cola Zero", date: Date(), calories: 4, type: .drinks),
            Entry(
                title: "Wein Weiß", date: Date(), calories: 72, type: .drinks),
        ]))
}
