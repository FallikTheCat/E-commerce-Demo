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
    @Published var priceList: [Int] = []
    
    //Reading the products from Firebase Database
    func getProducts() {
        database.child("SortedItems").child("byName").observe(.value, with: { snapshot  in
            guard let value = snapshot.value as? [String:[String:Any]] else {
                return
            }

            self.productList = []
            self.priceList = []
            
            value.forEach { (key,value) in
                if let name = value["name"] as? String, let price = value["price"] as? Int {
                    self.productList.append(name)
                    self.priceList.append(price)
                }
            }
        })
    }
    
}
