import SwiftUI

struct WaterEntryView: View {
    @Binding var waterEntry: Water
    @Binding var dailyWaterTarget: Int
    @Binding var date: Date
    
    @State var minWaterIntake = 0
    @State var showAddWater = false
    @State var waterAdded: Int = 0
    var body: some View {
        VStack {
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
            }.padding(.vertical)
            VStack {
                HStack{
                    Spacer()
                    Button{
                        showAddWater = true
                    } label:{
                        Image(systemName: "plus.app")
                    }
                }.padding(.vertical)
                
                if showAddWater {
                    VStack {
                        Stepper("Wasser (ml)", value: $waterAdded, in: 0...1000, step: 50)
                        Text("ml: \(waterAdded)")
                        Button{
                            waterEntry.quantity += waterAdded
                            showAddWater = false
                        } label:{
                            Text("Hinzufügen")
                        }.padding(.top, 16)
                            .disabled(waterAdded == 0)
                    }
                }
            }.padding(8)
            Spacer()
        }.padding()
        .navigationTitle("Wasseraufnahme \(date.formatted(date: Date.FormatStyle.DateStyle.numeric,time: Date.FormatStyle.TimeStyle.omitted))")
        .navigationBarTitleDisplayMode(.inline)
    }
}

