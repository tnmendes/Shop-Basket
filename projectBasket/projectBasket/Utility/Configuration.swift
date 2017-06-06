//
//  Configuration.swift
//  projectBasket
//
//  Created by Tiago Mendes on 06/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation

struct Configuration {
    
    
    /// Default currency code to be use as base to calculations
    static let defaultCurrencyCode              = "USD"
    /// URL of the API
    static let apiURL                           = "http://apilayer.net/api/"
    /// Key to access the API
    static let apiAccessKey                     = "c81b21e103e2711621dc2d6bb7cfdd7a"
    
    /// Generate URL that can be used to request quotes between two currencies
    ///
    /// - Parameter currency: currency code
    /// - Returns: URL
    static func getApiUrlQuotes(currency: String) -> String {
        return apiURL+"live?access_key="+apiAccessKey+"&currencies="+currency+"&source="+defaultCurrencyCode+"&format=1"
    }
    
    /// Generate URL that can be used to request the full list country names and currency codes
    ///
    /// - Returns: URL
    static func getApiUrlList() -> String {
        return apiURL+"list?access_key="+apiAccessKey+"&format=1"
    }
    
}
