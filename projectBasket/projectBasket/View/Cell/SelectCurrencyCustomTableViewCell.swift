//
//  SelectCurrencyCustomTableViewCell.swift
//  projectBasket
//
//  Created by Tiago Mendes on 06/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation
import UIKit

class SelectCurrencyCustomTableViewCell: UITableViewCell {
    
    let labName = UILabel()
    let labPrice = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        labName.translatesAutoresizingMaskIntoConstraints = false
        labPrice.translatesAutoresizingMaskIntoConstraints = false
        
        labName.textColor = UIColor.darkGray
        labName.font = labName.font.withSize(14)
        labPrice.textColor = UIColor.lightGray
        labPrice.font = labPrice.font.withSize(14)
        
        contentView.addSubview(labName)
        contentView.addSubview(labPrice)
        
        
        let viewsDict = [
            "name"      : labName,
            "price"     : labPrice,
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[price]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[name]-[price]-14-|", options: [], metrics: nil, views: viewsDict))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
