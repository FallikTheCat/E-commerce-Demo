//
//  ProductInfo.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 4.03.2021.
//

import Combine

class ProductInfo: ObservableObject {
    
    //Static Categories
    static let categories = ["Art", "Electronics", "Fashion", "Health", "Home", "Sports", "Tools & Equipment"]
    
    //Selected Category, number of stock, product name etc...
    @Published var category: Int = 0
    @Published var stock: Int = 1
    @Published var productName: String = ""
    @Published var productDetails: String = ""
    @Published var productPrice: String = ""
    
    //Checking if all information has been entered
    var isValid: Bool {
        if productName == "" || productDetails == "" || productPrice == "" {
            return false
        }
        
        return true
    }
}
