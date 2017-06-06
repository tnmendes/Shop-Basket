//
//  BasketCustomTableViewCell.swift
//  projectBasket
//
//  Created by Tiago Mendes on 06/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation
import UIKit

class BasketCustomTableViewCell: UITableViewCell {
    
    let labName = UILabel()
    let labPrice = UILabel()
    let labItem = UILabel()
    let buttonAdd = UIButton(type: .custom)
    let buttonRemove = UIButton(type: .custom)
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        labName.translatesAutoresizingMaskIntoConstraints = false
        labPrice.translatesAutoresizingMaskIntoConstraints = false
        labItem.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonRemove.translatesAutoresizingMaskIntoConstraints = false
        
        labName.textColor = UIColor.darkGray
        labName.font = labName.font.withSize(20)
        labPrice.textColor = UIColor.lightGray
        labPrice.font = labPrice.font.withSize(14)
        labItem.textColor = UIColor.lightGray
        labItem.font = labPrice.font.withSize(14)
        buttonAdd.backgroundColor = UIColor.green
        buttonAdd.setTitle("+", for: .normal)
        buttonAdd.setTitleColor(.white, for: .normal)
        
        buttonRemove.backgroundColor = UIColor.red
        buttonRemove.setTitle("-", for: .normal)
        buttonRemove.setTitleColor(.white, for: .normal)
        
        contentView.addSubview(labName)
        contentView.addSubview(labPrice)
        contentView.addSubview(labItem)
        contentView.addSubview(buttonAdd)
        contentView.addSubview(buttonRemove)
        
        let viewsDict = [
            "name"      : labName,
            "price"     : labPrice,
            "item"      : labItem,
            "btnAdd"    : buttonAdd,
            "btnRemove" : buttonRemove,
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-[price]-[item]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[btnAdd]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[btnRemove]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[name]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[price]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[item]-[btnRemove(40)]-10-[btnAdd(40)]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
