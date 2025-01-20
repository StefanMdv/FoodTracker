import Foundation

extension String {
    var formattedDouble: String {
        if let doubleValue = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            return formatter.string(from: NSNumber(value: doubleValue)) ?? self
        }
        return self
    }
}
