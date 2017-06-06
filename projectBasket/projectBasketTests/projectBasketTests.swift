//
//  projectBasketTests.swift
//  projectBasketTests
//
//  Created by Tiago Mendes on 05/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import XCTest
import Alamofire

@testable import projectBasket

class projectBasketTests: XCTestCase {
    
    private var listGoods: Array<Good>? = nil
    private let basket: Basket = Basket.sharedInstance
    
    override func setUp() {
        super.setUp()
        
        listGoods = Goods().getListGoods()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    /// Test the basket try to remove good that don't exist
    /// then add and remove twice
    func testThatCanAddAndRemoveFromBasket() {
        
        let selectedGood = listGoods?[0]
        
        XCTAssertFalse(basket.removeGood(good: selectedGood!))
        XCTAssert(basket.addGood(good: selectedGood!))
        XCTAssert(basket.removeGood(good: selectedGood!))
        XCTAssertFalse(basket.removeGood(good: selectedGood!))
    }
    
    
    /// Test the total price given by the basket. To do that we add some goods to the basket
    /// then we go direct to each good and make the calculation and compare with totalPrice given by the basket
    func testTotalPrice() {
        
        var bk = basket.getBasketList()
        bk.removeAll()
        basket.setCurrencyQuotes(currencyQuotes: 1.0)
        let selectedGood1 = listGoods?[0]
        let selectedGood2 = listGoods?[1]
        _ = basket.addGood(good: selectedGood1!)
        _ = basket.addGood(good: selectedGood1!)
        _ = basket.addGood(good: selectedGood2!)
        
        let testTotalPrice = (selectedGood1?.getPrice())! * 2 + (selectedGood2?.getPrice())!
        XCTAssertEqual(basket.totalPrice(), testTotalPrice)
    }
    
    
    /// Simple test just to check if the alamofire can comunicate with other server diferent from the API
    func testThatResponseReturnsSuccessResultWithValidData() {
        // Given
        let urlString = "https://httpbin.org/get"
        let expectation = self.expectation(description: "request should succeed")
        
        var response: DefaultDataResponse?
        
        // When
        Alamofire.request(urlString, parameters: ["foo": "bar"]).response { resp in
            response = resp
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 16.0, handler: nil)
        
        // Then
        XCTAssertNotNil(response?.request)
        XCTAssertNotNil(response?.response)
        XCTAssertNotNil(response?.data)
        XCTAssertNil(response?.error)
    }
    
    
    /// Test with alamofire if we can gest the list of coutries from the API
    /// In that list as to be the United state Dollar and Euro
    func testThatCanGetListFromAPI() {
        
        // Given
        let expectation = self.expectation(description: "request should succeed")
        var response: DataResponse<Any>?
        var valUSD: Bool = false
        var valEUR: Bool = false
        
        // When
        Alamofire.request(Configuration.getApiUrlList()).validate().responseJSON { resp in
            
            response = resp
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // Then
        let responseJSON = response?.result.value as! [String:AnyObject]
        for (currencyCode, countryName) in responseJSON["currencies"] as! NSDictionary {
            
            if(currencyCode as! String == "USD" && countryName as! String == "United States Dollar"){
                
                valUSD = true
            }
            
            if(currencyCode as! String == "EUR" && countryName as! String == "Euro"){
                
                valEUR = true
            }
        }
        
        XCTAssertNotNil(response?.request)
        XCTAssertNotNil(response?.response)
        XCTAssertNotNil(response?.data)
        XCTAssert(valUSD)
        XCTAssert(valEUR)
    }
    
    
    /// Test with alamofire to see if we can get quotes from the API
    /// To do that we select weak currency LAK that when compared with USD is weak coin
    /// So the value of the basket after change currency will be high then 100
    func testThatGetQuoteFromAPI() {
        
        // Given
        let expectation = self.expectation(description: "request should succeed")
        var response: DataResponse<Any>?
        let currency: String = "LAK" //Laotian Kip value is 1 USD = 8200 LAK
        var currencyQuote: Double = 0.0
        var basketList = basket.getBasketList()
        basketList.removeAll()
        
        let selectedGood1 = listGoods?[0]
        _ = basket.addGood(good: selectedGood1!)
        
        // When
        Alamofire.request(Configuration.getApiUrlQuotes(currency: currency)).validate().responseJSON { resp in
            
            response = resp
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // Then
        let responseJSON = response?.result.value as! [String:AnyObject]
        for (_, tempCurrencyQuote) in responseJSON["quotes"] as! NSDictionary {
            
            currencyQuote = tempCurrencyQuote as! Double
        }
        
        XCTAssertLessThan(basket.totalPrice(), 100)
        
        print("Value of the currency: \(currencyQuote)")
        basket.setCurrencyQuotes(currencyQuotes: currencyQuote)
        
        XCTAssertNotNil(response?.request)
        XCTAssertNotNil(response?.response)
        XCTAssertNotNil(response?.data)
        XCTAssertGreaterThan(100, basket.totalPrice())
        _ = basket.removeGood(good: selectedGood1!)
    }
    
    
    /// Test with alamofire to see if compared in the API two equal curricies the value is 1
    /// USD to USD = 1.000
    func testThatQuoteAsSameRateToTheSameQuoteInTheAPI() {
        
        // Given
        let expectation = self.expectation(description: "request should succeed")
        var response: DataResponse<Any>?
        let currency: String = Configuration.defaultCurrencyCode
        var currencyQuote: Double = 0.0
        
        // When
        Alamofire.request(Configuration.getApiUrlQuotes(currency: currency)).validate().responseJSON { resp in
            
            response = resp
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // Then
        let responseJSON = response?.result.value as! [String:AnyObject]
        for (_, tempCurrencyQuote) in responseJSON["quotes"] as! NSDictionary {
            
            currencyQuote = tempCurrencyQuote as! Double
        }
        
        print("Value of the currency: \(currencyQuote)")
        
        XCTAssertNotNil(response?.request)
        XCTAssertNotNil(response?.response)
        XCTAssertNotNil(response?.data)
        XCTAssertEqual( 1.0000, currencyQuote )
    }
    
    
    /// Test with alamofire to generated error in the API to do that we send invalid currency
    func testThatUnknownCurrencyDeliversAnError() {
        
        // Given
        let expectation = self.expectation(description: "request should succeed")
        var response: DataResponse<Any>?
        let currency: String = "ERRR" //invalid Currency
        var success: Bool = true
        
        // When
        Alamofire.request(Configuration.getApiUrlQuotes(currency: currency)).validate().responseJSON { resp in
            
            response = resp
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // Then
        let responseJSON = response?.result.value as! [String:AnyObject]
        success = responseJSON["success"] as! Bool
        
        XCTAssertNotNil(response?.request)
        XCTAssertNotNil(response?.response)
        XCTAssertNotNil(response?.data)
        XCTAssertFalse(success)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
