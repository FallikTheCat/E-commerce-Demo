//
//  ProductsView.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 5.03.2021.
//

import SwiftUI
import FirebaseDatabase

struct ProductsView: View {
    
    @ObservedObject var products: GetProducts
    
    private let database = Database.database().reference()
    
    func delete(at offsets: IndexSet) {
        database.child("SortedItems/byName/ajlsndalj").removeValue()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(products.productList.indices, id: \.self) { i in
                    NavigationLink(destination: ProductDetails(productCategory: products.productCategories[i], productDate: products.productDates[i], productDetails: products.productDetails[i], productId: products.productIDs[i], productName: products.productList[i], productPhotoURL: products.productPhotoURL[i], productPrice: products.priceList[i], productStock: products.productStocks[i])) {
                        HStack{
                            Text("\(products.productList[i])")
                            Spacer()
                            Text("₺\(products.priceList[i])")
                        }
                    }
                }.onDelete(perform: delete)
            }
            .navigationBarTitle(Text("ProductList"))
        }
    }
}
