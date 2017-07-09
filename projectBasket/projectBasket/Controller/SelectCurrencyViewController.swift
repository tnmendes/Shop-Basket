//
//  SelectCurrencyViewController.swift
//  projectBasket
//
//  Created by Tiago Mendes on 06/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class SelectCurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var myTableView: UITableView!
    private var listCurrency =  [[String]]()
    
    /// This method is called after the view controller has loaded its view hierarchy into memory.
    /// Here is configured the Table View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkGetListCurrency()
        
        myTableView = makeTableView()
        myTableView.register(SelectCurrencyCustomTableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        //Auto-set the UITableViewCells height (requires iOS8+)
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 20
        self.navigationItem.title = "Select Currency"
        
        self.view.addSubview(myTableView)
    }
    
    
    /// Helper funtion to creat full size Table
    ///
    /// - Returns: UITableView
    func makeTableView() -> UITableView {
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        return UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - (barHeight+navigationBarHeight)))
    }
    
    
    /// Get the list of currecies that that have to be show
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (listCurrency.count)
    }
    
    
    /// Feed each cell with country name and currency code
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectCurrencyCustomTableViewCell
        cell.labName.text = "\(listCurrency[indexPath.row][1])"
        cell.labPrice.text = "\(listCurrency[indexPath.row][0])"
        return cell
    }
    
    
    /// When cell is pressd, the basket update the currency code
    /// and then we pop the screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Basket.sharedInstance.setCurrencyCode(currencyCode: listCurrency[indexPath.row][0])
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    /// Request to the API all the list of the countries and the respected currency code
    /// After receiving the table view is update
    func networkGetListCurrency() {
        
        let rest = RestApiManager()
        rest.networkGetListCurrency(onSuccess: { (arr) -> () in
            
            for (currencyCode, countryName) in arr["currencies"] as! NSDictionary {
                
                self.listCurrency.append([currencyCode as! String, countryName as! String])
            }
            self.myTableView.reloadData()
        },
        onFailure: { (err) -> () in
            
            self.alert(message: "Fail to get Currency List")
        }
        )
    }
    
}
