import SwiftUI

struct TabHost: View {
    @State private var currentTab: TabItem = .dashboard
    @State private var trackerEntries = Entry.trackerEntriesMockData
    @State private var waterEntries = Water.waterMockData
    @State private var dailyIntake: DailyIntake = DailyIntake(calories: 0)
    @State private var dailyCalIntake: Int = 0
    @State private var dailyCalTarget: Int = 0
    @State private var dailyProteinTarget: Int = 0
    @State private var dailyFatTarget: Int = 0
    @State private var dailyCarbsTarget: Int = 0
    @State private var dailyWaterTarget: Int = 0
    @State private var user = User.user

    var body: some View {
            TabView(selection: $currentTab) {
                Tab(
                    TabItem.dashboard.title,
                    systemImage: TabItem.dashboard.icon,
                    value: .dashboard
                ) {
                    DashboardView(dailyIntake: $dailyIntake, dailyCalTarget: $dailyCalTarget, user: $user)
                }

                Tab(
                    TabItem.diary.title, systemImage: TabItem.diary.icon,
                    value: .diary
                ) {
                    EntryListView(
                        dailyCalIntake: $dailyCalIntake,
                        dailyCalTarget: $dailyCalTarget,
                        trackerEntries: $trackerEntries
                    )
                    .onChange(of: trackerEntries) { _, _ in
                        dailyIntake = calcDailyIntake()
                    }
                }
                
                Tab(
                    TabItem.water.title, systemImage: TabItem.water.icon,
                    value: .water
                ) {
                    WaterView(trackerEntries: $trackerEntries, waterEntries: $waterEntries, dailyWaterTarget: $dailyWaterTarget)
                }

                Tab(
                    TabItem.settings.title, systemImage: TabItem.settings.icon,
                    value: .settings
                ) {
                    SettingsView(dailyCalTarget: $dailyCalTarget, dailyProteinTarget: $dailyProteinTarget, dailyFatTarget: $dailyFatTarget, dailyCarbsTarget: $dailyCarbsTarget, dailyWaterTarget: $dailyWaterTarget, user: $user)
                }
            }.onAppear {
                dailyIntake = calcDailyIntake()
                loadUserData()
            }
        
    }

    func calcDailyIntake() -> DailyIntake {
        let dailyEntries = trackerEntries.filter {
            Calendar.current.isDate($0.date, inSameDayAs: Date())
        }
        
        let dailyWaterIntake = waterEntries.filter {
            Calendar.current.isDate($0.date, inSameDayAs: Date())
        }

        var cal = 0
        var carbs = 0
        var fat = 0
        var protein = 0
        let water = dailyWaterIntake[0].quantity

        dailyEntries.forEach {
            cal += $0.calories
            carbs += $0.carbs ?? 0
            fat += $0.fat ?? 0
            protein += $0.protein ?? 0
        }

        return DailyIntake(
            calories: cal, protein: protein, fat: fat, carbs: carbs, water: water)
    }
    
    func loadUserData() {
        dailyProteinTarget = user.dailyProteinTarget
        dailyFatTarget = user.dailyFatTarget
        dailyCarbsTarget = user.dailyCarbsTarget
        dailyCalTarget = user.dailyCalTarget
        dailyWaterTarget = user.dailyWaterTarget
        print(waterEntries)
    }
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    TabHost()
}
