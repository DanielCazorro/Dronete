import Foundation

final class AppSettings {

    private enum Keys {
        static let darkModeEnabled = "darkModeEnabled"
    }

    static var isDarkModeEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.darkModeEnabled)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.darkModeEnabled)
        }
    }
}
