import Foundation

extension Entry {
    static let today = Date()
    static let twoDaysAgo = Calendar.current.date(
        byAdding: .day, value: -2, to: today)!
    static let oneDayAgo = Calendar.current.date(
        byAdding: .day, value: -1, to: today)!

    static var trackerEntriesMockData = [
        
        Entry(
            title: "Spiegelei mit Speck", date: today, calories: 550,
            type: .breakfast, protein: 30, fat: 45, carbs: 10),
        Entry(
            title: "Semmel", date: today, calories: 150, type: .breakfast,
            protein: 4, fat: 2, carbs: 30),
        Entry(
            title: "Snickers", date: today, calories: 350, type: .snacks,
            protein: 4, fat: 19, carbs: 45),
        Entry(
            title: "Chips", date: today, calories: 380, type: .snacks,
            protein: 4, fat: 22, carbs: 40),
        Entry(
            title: "Spaghetti Bolognese", date: today, calories: 488,
            type: .lunch, protein: 35, fat: 22, carbs: 55),
        Entry(
            title: "Calamari", date: today, calories: 205, type: .lunch,
            protein: 20, fat: 10, carbs: 15),
        Entry(
            title: "Pommes", date: today, calories: 280, type: .lunch,
            protein: 3, fat: 15, carbs: 35),
        Entry(
            title: "Döner", date: today, calories: 550, type: .dinner,
            protein: 30, fat: 25, carbs: 40),
        Entry(
            title: "Latte Macchiato", date: today, calories: 75, type: .drinks,
            protein: 5, fat: 2, carbs: 10),
        Entry(
            title: "Cola Zero", date: today, calories: 4, type: .drinks,
            protein: 0, fat: 0, carbs: 1),
        Entry(
            title: "Wein Weiß", date: today, calories: 72, type: .drinks,
            protein: 0, fat: 0, carbs: 2),

        
        Entry(
                    title: "Omelette mit Gemüse", date: oneDayAgo, calories: 400,
                    type: .breakfast, protein: 25, fat: 20, carbs: 12),
                Entry(
                    title: "Croissant", date: oneDayAgo, calories: 180, type: .breakfast,
                    protein: 3, fat: 10, carbs: 25),
                Entry(
                    title: "Protein Bar", date: oneDayAgo, calories: 300, type: .snacks,
                    protein: 20, fat: 10, carbs: 30),
                Entry(
                    title: "Popcorn", date: oneDayAgo, calories: 220, type: .snacks,
                    protein: 4, fat: 10, carbs: 35),
                Entry(
                    title: "Chicken Caesar Salad", date: oneDayAgo, calories: 400,
                    type: .lunch, protein: 30, fat: 25, carbs: 15),
                Entry(
                    title: "Pasta Carbonara", date: oneDayAgo, calories: 550, type: .lunch,
                    protein: 28, fat: 25, carbs: 60),
                Entry(
                    title: "Grilled Vegetables", date: oneDayAgo, calories: 250, type: .lunch,
                    protein: 8, fat: 12, carbs: 30),
                Entry(
                    title: "Grilled Salmon", date: oneDayAgo, calories: 500, type: .dinner,
                    protein: 40, fat: 20, carbs: 5),
                Entry(
                    title: "Iced Coffee", date: oneDayAgo, calories: 100, type: .drinks,
                    protein: 5, fat: 5, carbs: 12),
                Entry(
                    title: "Orange Juice", date: oneDayAgo, calories: 110, type: .drinks,
                    protein: 1, fat: 0, carbs: 25),
                Entry(
                    title: "Wine Red", date: oneDayAgo, calories: 80, type: .drinks,
                    protein: 0, fat: 0, carbs: 5),
                
                
                Entry(
                    title: "Pancakes with Syrup", date: twoDaysAgo, calories: 450,
                    type: .breakfast, protein: 8, fat: 15, carbs: 60),
                Entry(
                    title: "Toast with Avocado", date: twoDaysAgo, calories: 230, type: .breakfast,
                    protein: 5, fat: 12, carbs: 30),
                Entry(
                    title: "Fruit Smoothie", date: twoDaysAgo, calories: 250, type: .snacks,
                    protein: 4, fat: 2, carbs: 50),
                Entry(
                    title: "Trail Mix", date: twoDaysAgo, calories: 300, type: .snacks,
                    protein: 8, fat: 18, carbs: 25),
                Entry(
                    title: "Grilled Chicken Sandwich", date: twoDaysAgo, calories: 500,
                    type: .lunch, protein: 40, fat: 15, carbs: 45),
                Entry(
                    title: "Vegetable Stir-Fry", date: twoDaysAgo, calories: 350, type: .lunch,
                    protein: 12, fat: 10, carbs: 50),
                Entry(
                    title: "Beef Burger", date: twoDaysAgo, calories: 600, type: .lunch,
                    protein: 40, fat: 35, carbs: 45),
                Entry(
                    title: "Steak with Potatoes", date: twoDaysAgo, calories: 700, type: .dinner,
                    protein: 50, fat: 40, carbs: 30),
                Entry(
                    title: "Lemonade", date: twoDaysAgo, calories: 90, type: .drinks,
                    protein: 0, fat: 0, carbs: 25),
                Entry(
                    title: "Coconut Water", date: twoDaysAgo, calories: 50, type: .drinks,
                    protein: 0, fat: 0, carbs: 12),
                Entry(
                    title: "Beer", date: twoDaysAgo, calories: 150, type: .drinks,
                    protein: 2, fat: 0, carbs: 13)
    ]
}


extension Water {
    static let today = Date()
    static let twoDaysAgo = Calendar.current.date(
        byAdding: .day, value: -2, to: today)!
    static let oneDayAgo = Calendar.current.date(
        byAdding: .day, value: -1, to: today)!
    
    static var waterMockData = [
        Water(quantity: 1500, date: today),
        Water(quantity: 2000, date: oneDayAgo),
        Water(quantity: 2000, date: twoDaysAgo)
    ]
}


extension User {
    static var user = User(username: "Stefan Moldoveanu", dailyCalTarget: 2550, dailyProteinTarget: 223, dailyFatTarget: 85, dailyCarbsTarget: 223, dailyWaterTarget: 3500)
}
