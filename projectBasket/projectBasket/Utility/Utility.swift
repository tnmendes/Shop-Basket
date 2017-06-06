//
//  Utility.swift
//  projectBasket
//
//  Created by Tiago Mendes on 06/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation

struct Utility {
    
    
    /// Function to help getting formatted currency
    ///
    /// - Parameters:
    ///   - value: value of cash
    ///   - currencyCode: currency code
    /// - Returns: formatted string
    static func formatCurrency(value: Double, currencyCode: String) -> String {
        
        let locale = NSLocale(localeIdentifier: currencyCode)
        let formatter = NumberFormatter()
        formatter.locale  = locale as Locale!
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencyCode = currencyCode
        formatter.maximumFractionDigits = 2;
        let result = formatter.string(from: value as NSNumber);
        return result!;
    }
}
