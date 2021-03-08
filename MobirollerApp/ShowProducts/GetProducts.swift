//
//  GetProducts.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 5.03.2021.
//

import Combine
import FirebaseDatabase

class GetProducts: ObservableObject {
    
    private let database = Database.database().reference()
    
    //Shared lists
    @Published var productList: [String] = []
    @Published var priceList: [String] = []
    @Published var productCategories: [Int] = []
    @Published var productDates: [String] = []
    @Published var productDetails: [String] = []
    @Published var productIDs: [String] = []
    @Published var productStocks: [Int] = []
    @Published var productPhotoURL: [String] = []
    
    @Published var sorting: String = "byStock"
    
    //Reading the products from Firebase Database
    func getProducts() {
        database.child("SortedItems").child("\(sorting)").observe(.value, with: { snapshot  in
            
            guard let value = snapshot.value as? [[String:Any]] else {
                
                self.productList = []
                self.priceList = []
                self.productCategories = []
                self.productDates = []
                self.productDetails = []
                self.productIDs = []
                self.productStocks = []
                self.productPhotoURL = []
                
                return
            }
            
            self.productList = []
            self.priceList = []
            self.productCategories = []
            self.productDates = []
            self.productDetails = []
            self.productIDs = []
            self.productStocks = []
            self.productPhotoURL = []
            
            value.forEach { value in
                if let category = value["category"] as? Int,
                   let date = value["date"] as? String,
                   let details = value["details"] as? String,
                   let id = value["id"] as? String,
                   let name = value["name"] as? String,
                   let photoURL = value["photoURL"] as? String,
                   let price = value["price"] as? String,
                   let stock = value["stock"] as? Int {
                    self.productCategories.append(category)
                    self.productDates.append(date)
                    self.productDetails.append(details)
                    self.productIDs.append(id)
                    self.productList.append(name)
                    self.productPhotoURL.append(photoURL)
                    self.priceList.append(price)
                    self.productStocks.append(stock)
                }
            }
            
        })
    }
    
}
