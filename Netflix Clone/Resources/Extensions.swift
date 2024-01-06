//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Marcel Mravec on 20.12.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
