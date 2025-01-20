enum TabItem {
    case dashboard, diary, water, settings
    
    var title: String {
        switch self {
        case .dashboard:
            return "Dashboard"
        case .diary:
            return "Tagebuch"
        case .settings:
            return "Einstellungen"
        case .water:
            return "Wasser"
        }
    }
    
    var icon: String {
        switch self {
        case .dashboard:
            return "gauge.open.with.lines.needle.33percent"
        case .diary:
            return "book.pages"
        case .settings:
            return "gear"
        case .water:
            return "drop.fill"
        }
    }
}
