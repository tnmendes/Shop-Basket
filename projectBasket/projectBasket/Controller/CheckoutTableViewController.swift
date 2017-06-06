//
//  CheckoutTableViewController.swift
//  projectBasket
//
//  Created by Tiago Mendes on 05/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import Foundation

import UIKit
import Alamofire


class CheckoutViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    private var listBasket: Array<BasketGood>? = []
    private var myTableView: UITableView!
    private var tempCurrency: String = ""
    private var labTotalPrice = UILabel()
    
    /// This method is called after the view controller has loaded its view hierarchy into memory.
    /// Here is configured the Table View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listBasket = Basket.sharedInstance.getBasketList()
        configureTableView()
        drawConstraints()
        
        self.navigationItem.title = "Checkout"
        tempCurrency = Basket.sharedInstance.getCurrencyCode()
    }
    
    
    /// Helper function to make the draw of the table View
    func drawConstraints() {
        
        let labStringTotalPrice = drawLabel(string: "Total Price:")
        let totalPrice = Basket.sharedInstance.totalPriceFormatted()
        labTotalPrice = drawLabel(string: "\(totalPrice)")
        let buttonChangeCurrency = drawButton()
        
        let viewsDict = [
            "table"         : myTableView,
            "stringTP"      : labStringTotalPrice,
            "price"         : labTotalPrice,
            "btnCurrency"   : buttonChangeCurrency,
            ] as [String : Any]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[table(>=80)]-[stringTP(40)]-[price(40)]-[btnCurrency(40)]-20-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[table]-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[stringTP]-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[price]-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[btnCurrency]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    
    /// Helper function to draw generic label
    func drawLabel(string: String) -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = string
        view.addSubview(label)
        return label
    }
    
    
    /// Helper function to draw UIButton to change the Currency
    func drawButton() -> UIButton {
        
        let buttonChangeCurrency = UIButton(type: .custom)
        buttonChangeCurrency.translatesAutoresizingMaskIntoConstraints = false
        buttonChangeCurrency.backgroundColor = UIColor.gray
        buttonChangeCurrency.setTitle("Currency Change", for: .normal)
        buttonChangeCurrency.setTitleColor(.white, for: .normal)
        buttonChangeCurrency.addTarget(self, action: #selector(self.buttonTappedChangeCurrency(sender:)), for: .touchUpInside)
        view.addSubview(buttonChangeCurrency)
        return buttonChangeCurrency
    }
    
    
    func configureTableView() {
        
        myTableView = makeTableView()
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        myTableView.register(CheckoutCustomTableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        //Auto-set the UITableViewCells height (requires iOS8+)
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 20
        view.addSubview(myTableView)
    }
    
    
    /// Helper funtion to creat full size Table
    ///
    /// - Returns: UITableView
    func makeTableView() -> UITableView {
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        let heightTableView: CGFloat = (( displayHeight - (barHeight+navigationBarHeight)) / 2 )
        
        return UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: heightTableView))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if( Basket.sharedInstance.getCurrencyCode() !=  tempCurrency ){ // The currency was changed
            
            networkGetCurrencyQuote(currency: Basket.sharedInstance.getCurrencyCode())
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// Get the list of goods that that have to be show
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (listBasket?.count)!
    }
    
    
    /// Feed each cell with all the information need to represent and Add buttons
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CheckoutCustomTableViewCell
        cell.labName.text = "\(listBasket![indexPath.row].getQuantity()) x \(listBasket![indexPath.row].getDescriptionContainer()) of \(listBasket![indexPath.row].getGood().getName())"
        
        return cell
    }
    
    
    /// Navigate to the Select Currency screen
    func buttonTappedChangeCurrency(sender: UIButton!){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "SelectCurrency", bundle: nil)
        let nextController = storyBoard.instantiateViewController(withIdentifier: "SelectCurrencyViewController") as! SelectCurrencyViewController
        navigationController?.pushViewController(nextController, animated: true)
    }
    
    
    /// Request to the API Quote between two currencies
    /// After the request the total price is updating to represent the new currency
    ///
    /// - Parameter currency: currency code
    private func networkGetCurrencyQuote(currency: String) {
        
        Alamofire.request(Configuration.getApiUrlQuotes(currency: currency)).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                let responseJSON = response.result.value as! [String:AnyObject]
                for (_, currencyQuotes) in responseJSON["quotes"] as! NSDictionary {
                    
                    Basket.sharedInstance.setCurrencyQuotes(currencyQuotes: currencyQuotes as! Double)
                }
                
                let totalPrice = Basket.sharedInstance.totalPriceFormatted()
                self.labTotalPrice.text = "\(totalPrice)"
                self.myTableView.reloadData()
                
            case .failure(let error):
                
                NSLog(error.localizedDescription)
                self.alert(message: "Fail to update Currency Quote")
            }
        }
    }
    
}
