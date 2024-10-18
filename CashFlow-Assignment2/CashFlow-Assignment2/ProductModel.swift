//
//  ProductModel.swift
//  CashFlow-Assignment2
//
//  Created by Archit Sehgal on 2024-10-17.
//

import Foundation

class ProductModel {
    var produtName : String = ""
    var quantity : Int = 0
    var price : Double = 0.0
    
    init (productName: String, quantity: Int, price: Double) {
        
        self.produtName = productName
        self.quantity = quantity
        self.price = price
    }
    
    func toString() -> String {
        return ("\(produtName) - \(quantity) - \(price)")
    }
}
