//
//  Good.swift
//  projectBasket
//
//  Created by Tiago Mendes on 05/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation

class Good {
    
    
    private let uid: Int
    private let name: String
    private let price: Double
    private let descriptionContainer: String
    private let descriptionContainerPlural: String
    
    
    /// Initializers
    ///
    /// - Parameters:
    ///   - uid: unique code
    ///   - name: description of the good
    ///   - price: price of the good
    ///   - descriptionContainer: optional, description of the good type in singular
    ///   - descriptionContainerPlural: optional, description of the good type in plural
    init(uid: Int, name: String, price: Double, descriptionContainer: String? = "", descriptionContainerPlural: String? = "") {
        
        self.uid = uid
        self.name = name
        self.price = price
        self.descriptionContainer = descriptionContainer!
        self.descriptionContainerPlural = descriptionContainerPlural!
    }
    
    
    /// Get Unique ID
    ///
    /// - Returns: the ID
    func getUid() -> Int {
        
        return uid
    }
    
    
    /// Get the description name of the Good
    ///
    /// - Returns: description
    func getName() -> String {
        
        return name
    }
    
    
    /// Get price of the Good
    ///
    /// - Returns: price
    func getPrice() -> Double {
        
        return price
    }
    
    
    /// Get description of the type in singular
    /// Ex: bottle | can | bag
    /// - Returns: description
    func getDescriptionContainer() -> String {
        
        return descriptionContainer
    }
    
    
    /// Get description of the type in plural
    /// Ex: bottles | cans | bags
    /// - Returns: description
    func getDescriptionContainerPlural() -> String {
        
        return descriptionContainerPlural
    }
    
}
