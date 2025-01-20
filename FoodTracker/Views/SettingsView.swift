import SwiftUI

struct SettingsView: View {
    @Binding var dailyCalTarget: Int
    @Binding var dailyProteinTarget: Int
    @Binding var dailyFatTarget: Int
    @Binding var dailyCarbsTarget: Int
    @Binding var dailyWaterTarget: Int
    @Binding var user: User
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text(initials(from: user.username))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 10)

                    Text("Hallo, \(user.username)!")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding(.top, 10)
                }
                List {
                    NavigationLink(destination: EmptyView()) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundColor(.blue)
                            Text("Profil")
                                .font(.headline)
                        }
                    }
                    
                    NavigationLink(
                        destination: DailyTargetView(
                            dailyCalTarget: $dailyCalTarget,
                            dailyProteinTarget: $dailyProteinTarget,
                            dailyFatTarget: $dailyFatTarget,
                            dailyCarbsTarget: $dailyCarbsTarget, dailyWaterTarget: $dailyWaterTarget, user: $user)
                    ) {
                        HStack {
                            Image(systemName: "target")
                                .foregroundColor(.blue)
                            Text("Ziele")
                                .font(.headline)
                        }
                    }

                    NavigationLink(destination: EmptyView()) {
                        HStack {
                            Image(systemName: "gear")
                                .foregroundColor(.blue)
                            Text("Einstellungen")
                                .font(.headline)
                        }
                    }

              
                }
                .listStyle(InsetGroupedListStyle())
                .padding(.top, 20)
            }
        }
    }

    private func initials(from username: String) -> String {
        let components = username.split(separator: " ")
        if components.count > 1 {
            return String(components[0].prefix(1))
                + String(components[1].prefix(1))
        } else {

            return String(components[0].prefix(1))
        }
    }
}
