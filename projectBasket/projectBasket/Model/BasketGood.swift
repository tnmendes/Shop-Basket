//
//  BasketGood.swift
//  projectBasket
//
//  Created by Tiago Mendes on 05/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation

class BasketGood {
    
    weak private var objGood: Good?
    private var quantity: Int
    
    
    /// Initializers
    ///
    /// - Parameters:
    ///   - objGood: object of type Good
    ///   - quantity: optional field
    init(objGood: Good, quantity: Int? = 1) {
        
        self.objGood = objGood
        self.quantity = quantity!
    }
    
    
    /// Get the object Good
    ///
    /// - Returns: object Good
    func getGood() -> Good {
        
        return objGood!
    }
    
    
    /// Get the amount of goods of just one type
    ///
    /// - Returns: quantity of goods
    func getQuantity() -> Int {
        
        return quantity
    }
    
    
    /// This function will return the singular or the plural based on the amount of goods that are in the basket
    /// Ex:
    ///    1 x bottle of milk | 5 x bottles of milk
    ///
    /// - Returns: string with description of the good type in plural or singular
    func getDescriptionContainer() -> String {
        
        if(quantity >= 2){
            
            if(!(objGood?.getDescriptionContainerPlural().isEmpty)!){
                
                let string = objGood?.getDescriptionContainerPlural()
                return string!
            }
        }
        
        let string = objGood?.getDescriptionContainer()
        return string!
    }
    
    
    /// Adding quantity to this object
    ///
    /// - Parameter quantity: optional field
    /// - Returns: state of the operation
    func addQuantity(quantity: Int? = 1) -> Bool {
        
        self.quantity += quantity!
        return true
    }
    
    
    /// Removing quantity to this object
    ///
    /// - Parameter quantity: optional field
    /// - Returns: the quantity after removing the good
    func removeQuantity(quantity: Int? = 1) -> Int {
        
        self.quantity -= quantity!
        if( self.quantity <= 0){
            
            objGood = nil
            return 0
        }
        return self.quantity
    }
    
    
    /// Get the total price of the goods contained in this object
    ///
    /// - Returns: total price of this good
    func totalPriceOfGood() -> Double {
        
        return (objGood?.getPrice())! * Double(quantity)
    }
    
    
    /// perform the deinitialization
    deinit {
        
        objGood = nil
        quantity = 0
    }
    
    
}
