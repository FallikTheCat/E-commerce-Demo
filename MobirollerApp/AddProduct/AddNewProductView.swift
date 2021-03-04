//
//  AddNewProductView.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 4.03.2021.
//

import SwiftUI
import FirebaseDatabase

struct AddNewProductView: View {
    
    private let database = Database.database().reference()
    
    //Converting current date format to string
    let currentDate: String = {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateToString = dateFormatter.string(from: date)
        return dateToString
    }()
    
    //Writing the data to Firebase Realtime-Database
    func addNewProduct() {
        let productInfo: [String: Any] = [
            "category": $product.category.wrappedValue,
            "date": currentDate,
            "details": $product.productDetails.wrappedValue,
            "name": $product.productName.wrappedValue,
            "price": $product.productPrice.wrappedValue
        ]
        
        database.child("Products").child("Category\($product.category.wrappedValue)").child("SN\(Int.random(in: 0..<100))").setValue(productInfo)
    }
    
    func getProducts() {
        database.child("Products").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            print("Value: \(value)")
        })
    }
    
    @ObservedObject var product = ProductInfo()
    
    var body: some View {
        
        NavigationView {
            Form {
                Picker(selection: $product.category, label: Text("Select Category")) {
                    ForEach(0 ..< ProductInfo.categories.count) {
                        Text(ProductInfo.categories[$0]).tag($0)
                    }
                }
                
                Stepper(value: $product.stock, in: 1...100) {
                    Text("In Stock: \(product.stock)")
                }
                
                Section {
                    TextField("Product Name", text: $product.productName)
                    TextField("Price", text: $product.productPrice)
                }
                
                Section {
                    HStack{
                        Text("Details: ")
                        TextEditor(text: $product.productDetails)
                    }
                }
                
                Section {
                    Button(action: {
                        addNewProduct()
                    }) {
                        Text("Add Product")
                    }
                }.disabled(!product.isValid)
            }
            .navigationBarTitle(Text("Add New Product"))
        }
        
    }
}

struct AddNewProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProductView()
    }
}
