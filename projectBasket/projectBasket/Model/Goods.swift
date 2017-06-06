//
//  Goods.swift
//  projectBasket
//
//  Created by Tiago Mendes on 06/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation

class Goods {
    
    
    /// Array to populate the list of the goods
    let arrGoodsToPopulate =   [
        ["Peas", 0.95, "bag", "bags"],
        ["Eggs", 2.10, "dozen","dozen"],
        ["Milk", 1.30, "bottle", "bottles"],
        ["Beans", 0.73, "can", "cans"]
    ]
    var arrGoods: Array<Good>? = []
    
    
    /// Initializers
    init() {
    }
    
    
    /// Get list of Goods to be sell
    ///
    /// - Returns: Array that contains all the Goods
    func getListGoods() -> Array<Good>{
        
        if(arrGoods?.isEmpty)!{
            
            populate()
        }
        return arrGoods!
    }
    
    
    /// Function that populate the array of Goods
    private func populate() {
        
        for good in arrGoodsToPopulate {
            
            arrGoods?.append(Good(name: good[0] as! String,
                                  price: good[1] as! Double,
                                  descriptionContainer: good[2] as? String,
                                  descriptionContainerPlural: good[3] as? String))
        }
    }
    
}
