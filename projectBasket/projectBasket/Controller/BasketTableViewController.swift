//
//  BasketTableViewController.swift
//  projectBasket
//
//  Created by Tiago Mendes on 05/06/2017.
//  Copyright © 2017 mendes. All rights reserved.
//

import UIKit

class BasketTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// List of the goods that will be show
    private var listGoods: Array<Good>? = nil
    /// Var with the table that is used in this screen
    private var myTableView: UITableView!
    
    
    /// This method is called after the view controller has loaded its view hierarchy into memory.
    /// Here is configured the Table View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listGoods = Goods().getListGoods()
        
        myTableView = makeTableView()
        myTableView.register(BasketCustomTableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        //Auto-set the UITableViewCells height (requires iOS8+)
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 98
        
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationItem.title = "Basket"
        let rightButton = UIBarButtonItem(title: "Checkout", style: .plain, target: self, action: #selector(self.buttonTappedCheckout))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    
    
    /// Get the list of goods that that have to be show
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (listGoods?.count)!
    }
    
    
    /// Feed each cell with all the information need to represent and Add buttons
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BasketCustomTableViewCell
        cell.labName.text = "\(listGoods![indexPath.row].getName())"
        
        cell.labPrice.text = Utility.formatCurrency(value: listGoods![indexPath.row].getPrice(), currencyCode: Configuration.defaultCurrencyCode)
        cell.buttonAdd.tag = indexPath.row
        cell.buttonAdd.addTarget(self, action: #selector(self.buttonTappedAdd(sender:)), for: .touchUpInside)
        cell.buttonRemove.tag = indexPath.row
        cell.buttonRemove.addTarget(self, action: #selector(self.buttonTappedRemove(sender:)), for: .touchUpInside)
        cell.labItem.text = "Item: \(Basket.sharedInstance.getQuantity(good: listGoods![indexPath.row]))"
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    /// Navigate to the Checkout
    func buttonTappedCheckout(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Checkout", bundle: nil)
        let nextController = storyBoard.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        navigationController?.pushViewController(nextController, animated: true)
    }
    
    
    /// Add select good to the basket
    ///
    /// - Parameter sender: UIButton
    func buttonTappedAdd(sender: UIButton!){
        
        let selectedGood = listGoods?[sender.tag]
        NSLog("SelectCurrency :: add :: "+(listGoods?[sender.tag].getName())!)
        if(Basket.sharedInstance.addGood(good: selectedGood!)){
            
            let indexPath = IndexPath(item: sender.tag, section: 0)
            myTableView.reloadRows(at: [indexPath], with: .fade)
        }else{
            
            alert(message: "Someting happen and we couldn't add item to the basket")
        }
    }
    
    
    /// Remove select good of the basket
    ///
    /// - Parameter sender: UIButton
    func buttonTappedRemove(sender: UIButton!){
        
        let selectedGood = listGoods?[sender.tag]
        if(Basket.sharedInstance.removeGood(good: selectedGood!)){
            
            NSLog("SelectCurrency :: remove :: "+(listGoods?[sender.tag].getName())!)
        }
        
        let indexPath = IndexPath(item: sender.tag, section: 0)
        myTableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}
