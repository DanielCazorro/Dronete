//
//  Extensions.swift
//  Dronete
//
//  Created by Daniel Cazorro Frías on 9/9/24.
//

import Foundation

extension String {
    static var empty: String {
        return ""
    }
}


extension String {
    var isBlank: Bool {
        return allSatisfy { $0.isWhitespace }
    }
}

extension Optional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
}

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cleanedHex.hasPrefix("#") {
            cleanedHex.remove(at: cleanedHex.startIndex)
        }

        guard cleanedHex.count == 6,
              let rgbValue = UInt32(cleanedHex, radix: 16) else {
            return nil
        }

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}

extension DispatchQueue {
    static func mainAsyncIfNeeded(_ execute: @escaping () -> Void) {
        if Thread.isMainThread {
            execute()
        } else {
            DispatchQueue.main.async {
                execute()
            }
        }
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

