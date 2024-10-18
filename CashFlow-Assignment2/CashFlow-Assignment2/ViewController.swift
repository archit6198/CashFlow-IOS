//
//  ViewController.swift
//  Assingment-2
//
//  Created by Archit Sehgal on 2024-10-17.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var selectedProduct: UILabel!
    
    @IBOutlet weak var enteredQuantity: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var one: UIButton!
    
    @IBOutlet weak var two: UIButton!
    
    @IBOutlet weak var three: UIButton!
    
    @IBOutlet weak var four: UIButton!
    
    @IBOutlet weak var five: UIButton!
    
    @IBOutlet weak var six: UIButton!
    
    @IBOutlet weak var seven: UIButton!
    
    @IBOutlet weak var eight: UIButton!
    
    @IBOutlet weak var nine: UIButton!
    
    @IBOutlet weak var zero: UIButton!
    
    @IBOutlet weak var clear: UIButton!
    
    
    var productNames = ["Bags", "Watches", "Belts", "Gloves", "Sunglasses", "Scaf"]
    
    var productQuantity = [12, 30, 25, 15, 20, 40]
    
    var productPrices = [39.99, 59.99, 29.99, 44.99, 89.99, 14.99]
    
    var allProducts = (UIApplication.shared.delegate as! AppDelegate).allProducts
    
    var currentQuantity: String = "" {
        didSet {
            enteredQuantity.text = currentQuantity
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadProducts()
        allProducts = (UIApplication.shared.delegate as! AppDelegate).allProducts
        print(allProducts)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allProducts = (UIApplication.shared.delegate as! AppDelegate).allProducts
        tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        let arrayIndex = indexPath.row
        cell.textLabel?.text = "Name: \(allProducts[arrayIndex].produtName) - Quantity: \(allProducts[arrayIndex].quantity)"
        cell.detailTextLabel?.text = "\(allProducts[arrayIndex].price)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProductInfo = allProducts[indexPath.row]
        selectedProduct.text = "\(selectedProductInfo.produtName)"
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func loadProducts() {
        for i in 0..<min(productNames.count, productQuantity.count, productPrices.count) {
            let newProduct = ProductModel(productName: productNames[i], quantity: productQuantity[i], price: productPrices[i])
            (UIApplication.shared.delegate as! AppDelegate).allProducts.append(newProduct)
        }
    }
    
    @IBAction func managerPageBtnTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showManagerPage", sender: self)
    }
    
    
    
    @IBAction func numberClicked(_ sender: UIButton) {
        if let numberTitle = sender.titleLabel?.text {
            currentQuantity += numberTitle
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        currentQuantity = ""
    }
    
    
    @IBAction func buyClicked(_ sender: Any) {
            guard let selectedProductName = selectedProduct.text, !selectedProductName.isEmpty else {
                showAlert(message: "No product selected.")
                return
            }
            
            guard let quantity = Int(currentQuantity), quantity > 0 else {
                showAlert(message: "Invalid quantity entered.")
                return
            }
            
            guard let selectedProductInfo = allProducts.first(where: { $0.produtName == selectedProductName }) else {
                showAlert(message: "Product not found.")
                return
            }
        
            if quantity > selectedProductInfo.quantity {
                 showAlert(message: "Entered quantity exceeds available quantity of \(selectedProductInfo.quantity).")
                 return
             }
            
            let totalPrice = ceil(Double(quantity) * selectedProductInfo.price)
            
        let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            let purchaseDate = dateFormatter.string(from: Date())
            
            let historyItem = HistoryModel(productName: selectedProductInfo.produtName, quantity: quantity, date: purchaseDate, total: totalPrice)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.buyHistory.append(historyItem)

            showAlert(message: "Total price for \(quantity) \(selectedProductInfo.produtName)(s): $\(totalPrice)")
            selectedProduct.text = ""
            currentQuantity = ""
        }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Purchase Information", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


