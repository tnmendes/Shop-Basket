//
//  RestApiManager.swift
//  projectBasket
//
//  Created by Tiago Mendes on 07/07/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation
import Alamofire

enum UnauthorizedError : Error {
    case RuntimeError(String)
}


class RestApiManager {
    
    /// Request to the API all the list of the countries and the respected currency code
    /// After receiving the table view is update
    func networkGetListCurrency(onSuccess: @escaping (AnyObject) -> Void , onFailure: @escaping (Error) -> Void) {
        
        Alamofire.request(Configuration.getApiUrlList()).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                if let responseJSON = response.result.value {
                    
                    onSuccess(responseJSON as AnyObject)
                }
            case .failure(let error):
                
                NSLog(error.localizedDescription)
                onFailure(UnauthorizedError.RuntimeError(error.localizedDescription))
            }
        }
    }
    
    
    
    /// Request to the API Quote between two currencies
    /// After the request the total price is updating to represent the new currency
    ///
    /// - Parameter currency: currency code
    func networkGetCurrencyQuote(currency: String, onSuccess: @escaping (AnyObject) -> Void , onFailure: @escaping (Error) -> Void) {
        
        Alamofire.request(Configuration.getApiUrlQuotes(currency: currency)).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                if let responseJSON = response.result.value {
                    
                     onSuccess(responseJSON as AnyObject)
                }
            case .failure(let error):
                
                NSLog(error.localizedDescription)
                onFailure(UnauthorizedError.RuntimeError(error.localizedDescription))
            }
        }
    }


}
