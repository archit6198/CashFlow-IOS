//
//  HistoryModel.swift
//  CashFlow-Assignment2
//
//  Created by Created by Archit Sehgal on 2024-10-17.
//

import Foundation

class HistoryModel {
    var productName : String = ""
    var quantity : Int = 0
    var date : String = ""
    var total : Double = 0
    
    init(productName: String, quantity: Int, date: String, total: Double) {
        self.productName = productName
        self.quantity = quantity
        self.date = date
        self.total = total
    }
    
}
