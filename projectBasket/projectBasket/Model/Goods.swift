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
        [10001, "Peas", 0.95, "bag", "bags"],
        [10002, "Eggs", 2.10, "dozen","dozen"],
        [10003, "Milk", 1.30, "bottle", "bottles"],
        [10004, "Beans", 0.73, "can", "cans"]
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
            
            arrGoods?.append(Good(uid: good[0] as! Int,
                                  name: good[1] as! String,
                                  price: good[2] as! Double,
                                  descriptionContainer: good[3] as? String,
                                  descriptionContainerPlural: good[4] as? String))
        }
    }

}
