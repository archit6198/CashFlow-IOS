//
//  managerHistoryAll.swift
//  CashFlow-Assignment2
//
//  Created by Archit Sehgal on 2024-10-17.
//

import UIKit

class managerHistoryAll: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var purchaseHistory = (UIApplication.shared.delegate as! AppDelegate).buyHistory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        purchaseHistory = (UIApplication.shared.delegate as! AppDelegate).buyHistory
        tableView.reloadData()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchaseHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let historyItem = purchaseHistory[indexPath.row]
        
        cell.textLabel?.text = "\(historyItem.productName) - Quantity: \(historyItem.quantity)"
        cell.detailTextLabel?.text = "Date: \(historyItem.date) - Total: $\(historyItem.total)"
        
        return cell
    }

}
