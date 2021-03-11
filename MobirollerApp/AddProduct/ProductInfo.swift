//
//  ProductInfo.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 4.03.2021.
//

import Combine
import SwiftUI

class ProductInfo: ObservableObject {
    
    //Static Categories
    static let categories = ["Art", "Electronics", "Fashion", "Health", "Home", "Sports", "Tools"]
    
    //Selected Category, number of stock, product name etc...
    @Published var category: Int = 0
    @Published var stock: Int = 1
    @Published var productName: String = ""
    @Published var productDetails: String = ""
    @Published var productPrice: Int = 00
    @Published var productImage: Image?
}
