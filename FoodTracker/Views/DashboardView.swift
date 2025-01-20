import SwiftUI

struct DashboardView: View {
    @Binding var dailyIntake: DailyIntake
    @Binding var dailyCalTarget: Int
    @Binding var user: User
    
    
    
    var body: some View {
        VStack {
            NavigationStack {
                NavigationLink {
                    DashboardDetails(dailyIntake: $dailyIntake, dailyCalTarget: $dailyCalTarget, user: $user)
                } label: {
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 24)
                            .frame(width: 250, height: 250)

                        Gauge(
                            value: Double(dailyIntake.calories),
                            in: 0...Double(dailyCalTarget)
                        ) {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.red)
                        } currentValueLabel: {
                            Text("\(dailyIntake.calories)")
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(.primary)
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(Gradient(colors: [.orange, .red]))
                        .scaleEffect(3.5)

                        VStack {
                            Spacer()
                            Text("von \(dailyCalTarget) kcal")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        .padding(.bottom, 20)
                    }
                    .frame(height: 300)
                    .padding()
                }
            }

        }
    }
    
    
}

