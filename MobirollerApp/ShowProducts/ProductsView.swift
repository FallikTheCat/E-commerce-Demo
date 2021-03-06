//
//  ProductsView.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 5.03.2021.
//

import SwiftUI

struct ProductsView: View {
    
    @ObservedObject var products: GetProducts
    
    var body: some View {
        NavigationView {
            List {
                ForEach(products.productList.indices, id: \.self) { i in
                    NavigationLink(destination: ProductDetails()) {
                        HStack{
                            Text("\(products.productList[i])")
                            Spacer()
                            Text("\(products.priceList[i])")
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Product List"))
        }
    }
}
