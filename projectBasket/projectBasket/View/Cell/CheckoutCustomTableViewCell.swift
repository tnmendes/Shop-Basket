//
//  CheckoutCustomTableViewCell.swift
//  projectBasket
//
//  Created by Tiago Mendes on 06/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation
import UIKit

class CheckoutCustomTableViewCell: UITableViewCell {
    
    let labName = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        labName.translatesAutoresizingMaskIntoConstraints = false
        
        labName.textColor = UIColor.darkGray
        labName.font = labName.font.withSize(14)
        
        contentView.addSubview(labName)
        
        
        let viewsDict = [
            "name"      : labName,
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[name]", options: [], metrics: nil, views: viewsDict))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
