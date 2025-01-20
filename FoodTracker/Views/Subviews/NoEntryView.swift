import SwiftUI

struct NoEntryView: View {
    var body: some View {
        HStack{
            Text("Keine Enträge vorhanden ...")
                .foregroundColor(.gray)
                .italic()
        }.padding(8)
    }
}


