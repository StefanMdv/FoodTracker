import Foundation
struct Water: Identifiable {
    var id: String =  UUID().uuidString
    var quantity: Int
    var date: Date = Date()
}
