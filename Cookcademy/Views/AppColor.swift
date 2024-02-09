//
//  AppColor.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 08.04.2023.
//
import SwiftUI
import Foundation

struct AppColor {
    static let background: Color = Color(.sRGB,
                                           red: 228/255,
                                           green: 235/255,
                                           blue: 250/255,
                                           opacity: 1)
    static let foreground: Color = Color(.sRGB,
                                           red: 118/255,
                                           green: 119/255,
                                           blue: 231/255,
                                           opacity: 1)
    static let listHeaderColor = Color(.blue)
}

extension Color: RawRepresentable {
    
    public init?(rawValue: String) {
        do {
            let encodedData = rawValue.data(using: .utf8)!
            let components = try JSONDecoder().decode([Double].self, from: encodedData)
            self = Color(red: components[0], green: components[1], blue: components[2], opacity: components[3])
        }
        catch {
            return nil
        }
    }
    
    public var rawValue: String {
        guard let cgFloatComponents = UIColor(self).cgColor.components else {
            return "nil"
        }
        let doubleComponentas = cgFloatComponents.map { Double($0) }
        do {
            let encodedComponents = try JSONEncoder().encode(doubleComponentas)
            return String(data: encodedComponents, encoding: .utf8) ?? "nil"
        }
        catch {
            return "nil"
        }
    }
}
