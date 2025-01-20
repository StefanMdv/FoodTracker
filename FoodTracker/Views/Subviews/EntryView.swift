import SwiftUI

struct EntryView: View {
    var trackerEntry: Entry
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(trackerEntry.title)
                        .bold()
                        .italic()
                    Spacer()
                }
                Spacer().frame(height: 8)
                HStack {
                    Text(
                        "\(trackerEntry.date, formatter: dateFormatter)"
                    )
                    Spacer()
                }
            }

            Spacer()

            VStack {
                Text("\(trackerEntry.calories)")
                Text("kcal")
            }.padding(8)
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))

        }.padding(4)
    }

    
}

#Preview {
    EntryView(
        trackerEntry: 
            Entry(
                title: "Weißwurst mit Brezel", date: Date(), calories: 500,
                type: .breakfast))
}
