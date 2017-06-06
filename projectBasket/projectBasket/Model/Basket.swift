//
//  Basket.swift
//  projectBasket
//
//  Created by Tiago Mendes on 05/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation

class Basket {
    
    
    static let sharedInstance = Basket() //Singleton
    private var basketList: Array<BasketGood>? = []
    private var currencyCode: String
    private var currencyQuotes: Double = 1.0
    
    
    /// Initializers
    /// Singleton, start the object with sharedInstance instead of the init
    private init() {
        
        currencyCode = Configuration.defaultCurrencyCode
    }
    
    
    /// Get list of Goods inside the Basket
    ///
    /// - Returns: Array of BasketGood
    public func getBasketList() -> Array<BasketGood> {
        
        return basketList!
    }
    
    
    /// Get The currency Code
    ///
    /// - Returns: Currency Code ex: USD, EUR
    public func getCurrencyCode() -> String {
        
        return currencyCode
    }
    
    
    /// Set the new Currency Code
    /// Currency codes are composed of a country's two-character Internet country code plus a third character denoting the currency unit.
    ///
    /// - Parameter currencyCode: USD, EUR
    public func setCurrencyCode(currencyCode: String) {
        
        self.currencyCode = currencyCode
    }
    
    
    /// Value that then gonna be used to make the calculation between the default currency and the new one
    /// Example: USD and EUR 0.888802
    ///
    /// - Parameter currencyQuotes: Double
    public func setCurrencyQuotes(currencyQuotes: Double) {
        
        self.currencyQuotes = currencyQuotes
    }
    
    
    /// Adding good to the basket
    ///
    /// - Parameter good: object of type Good
    /// - Returns: status of adding the good to the list
    public func addGood(good: Good) -> Bool {
        
        for (basketGood) in basketList! {
            
            if(good === basketGood.getGood()){
                
                return basketGood.addQuantity()
            }
        }
        basketList?.append(BasketGood(objGood: good))
        return true
    }
    
    
    /// Removing the good of the basket
    ///
    /// - Parameter good: object of type Good
    /// - Returns: status of removing good of the list
    public func removeGood(good: Good) -> Bool {
        
        var i: Int = 0
        for (basketGood) in basketList! {
            
            if(good === basketGood.getGood()){
                
                let numGoods =  basketGood.removeQuantity()
                if(numGoods <= 0){
                    
                    basketList?.remove(at: i)
                }
                return true
            }
            i += 1
        }
        return false
    }
    
    
    /// Get amount of determined good in the basket
    ///
    /// - Parameter good: object type good
    /// - Returns: amount of goods
    public func getQuantity(good: Good) -> Int {
        
        for (basketGood) in basketList! {
            
            if(good === basketGood.getGood()){
                
                return basketGood.getQuantity()
            }
        }
        
        return 0
    }
    
    
    /// Calculate the total price of all the goods in the basket
    ///
    /// - Returns: total value in the basket
    public func totalPrice() -> Double {
        
        var totalPrice: Double = 0.00
        for goodInList in basketList! {
            
            totalPrice += goodInList.totalPriceOfGood()
        }
        
        if(!currencyCode.isEmpty && currencyCode != Configuration.defaultCurrencyCode){
            
            totalPrice = totalPrice * currencyQuotes
        }
        
        return totalPrice
    }
    
    
    /// The total price will be formatted as currency displaying two decimal places
    /// And iOS have the representation of the coin it will show else it will shou the currency code
    /// Ex: US Dollar: $ 1.30 | Afghan Afghani: AFN 1.30
    ///
    /// - Returns: Formatted Currency
    public func totalPriceFormatted() -> String {
        
        return Utility.formatCurrency(value: totalPrice(), currencyCode: currencyCode)
    }
}
