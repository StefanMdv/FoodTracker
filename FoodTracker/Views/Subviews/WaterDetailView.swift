import SwiftUI

struct WaterDetailView: View {
    @Binding var waterEntry: Water
    @Binding var dailyWaterTarget: Int
    @Binding var date: Date
    @State var minWaterIntake = 0
    var body: some View {
        NavigationLink {
            WaterEntryView(waterEntry: $waterEntry, dailyWaterTarget: $dailyWaterTarget, date: $date)
        }label: {
            HStack {
                Gauge(value: Double(waterEntry.quantity), in: 0...Double(dailyWaterTarget)) {
                    Text("")
                } currentValueLabel: {
                    Text( "\(waterEntry.quantity)ml")
                } minimumValueLabel: {
                    Text("\(minWaterIntake)")
                } maximumValueLabel: {
                    Text("\(dailyWaterTarget)ml")
                }
                .padding(16)
                .tint(Int(waterEntry.quantity) > dailyWaterTarget ? .red : .blue)
            }
        }    }
}
