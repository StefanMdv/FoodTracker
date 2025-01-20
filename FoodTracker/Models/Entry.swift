import Foundation

struct Entry: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var title: String
    var date: Date
    var calories: Int
    var type: EntryType
    var protein: Int?
    var fat: Int?
    var carbs: Int?
}
