//
//  ContentView.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 4.03.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var products = GetProducts()
    @State var selected = 0
    
    var body: some View {
        TabView(selection: $selected) {
            ProductsView(products: products)
                .tabItem {
                    if self.selected == 0 {
                        Image(systemName: "tray.and.arrow.down")
                        Text("Products")
                    }else {
                        Image(systemName: "tray.and.arrow.down.fill")
                        Text("Products")
                    }
                }.tag(0)
            AddNewProductView(selection: $selected, products: products)
                .tabItem {
                    if self.selected == 1 {
                        Image(systemName: "icloud.and.arrow.up")
                        Text("AddProduct")
                    }else {
                        Image(systemName: "icloud.and.arrow.up.fill")
                        Text("AddProduct")
                    }
                }.tag(1)
        }.onAppear(perform: products.getProducts)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
