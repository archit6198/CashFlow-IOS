//
//  managerRestockHome.swift
//  CashFlow-Assignment2
//
//  Created by Archit Sehgal on 2024-10-17.
//

import UIKit

class managerRestockHome: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var selectedProduct: UILabel!
    
    @IBOutlet weak var enteredQuantity: UITextField!
    
    var selectedProductIndex: IndexPath?
    
    var allProducts = (UIApplication.shared.delegate as! AppDelegate).allProducts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        allProducts = (UIApplication.shared.delegate as! AppDelegate).allProducts
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProductIndex = indexPath
        let productItem = allProducts[indexPath.row]
        selectedProduct.text = productItem.produtName
        enteredQuantity.text = ""
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let productItem = allProducts[indexPath.row]
        
        cell.textLabel?.text = "\(productItem.produtName)"
        cell.detailTextLabel?.text = "\(productItem.quantity)"
        
        return cell
    }

    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restockBtn(_ sender: Any) {
        guard let indexPath = selectedProductIndex else {
            showErrorAlert("Please select a product to restock.")
            return
        }
                
        guard let quantityText = enteredQuantity.text, let quantity = Int(quantityText), quantity > 0 else {
            showErrorAlert("Please enter a valid quantity.")
            return
        }
                
        let productItem = allProducts[indexPath.row]
        productItem.quantity += quantity
                
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.allProducts[indexPath.row] = productItem
                
        tableView.reloadRows(at: [indexPath], with: .automatic)
                
        selectedProduct.text = ""
        enteredQuantity.text = ""
        showErrorAlert("Restocked \(quantity) units of \(productItem.produtName). New quantity: \(productItem.quantity).")
    }
    
    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Notification", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
