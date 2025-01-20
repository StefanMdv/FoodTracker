import SwiftUI

struct DashboardDetailsProgress: View {
    var title: String
    var current: Int
    var target: Int
    var unit: String

    
    private var progress: Double {
        guard target > 0 else { return 0 }
        return Double(current) / Double(target)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)

            Gauge(value: progress, in: 0...1) {
                Text("")
            }
            .tint(progress >= 1.0 ? .red : .blue)

            Text(
                "Fortschritt: \(Int(progress * 100))% (\(current) \(unit) / \(target) \(unit))"
            )
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}
