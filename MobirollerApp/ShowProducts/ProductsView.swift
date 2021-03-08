//
//  ProductsView.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 5.03.2021.
//

import SwiftUI

struct ProductsView: View {
    
    @ObservedObject var products: GetProducts
    
    @State var sorting = ["byName", "byStock", "byPriceHigh", "byPriceLow", "byCategory"]
    @State private var showPicker = false
    
    //Localization for the picker
    func localizedSortingKey() -> LocalizedStringKey {
        let sorting = products.sorting
        let sortingLocalized = LocalizedStringKey(sorting)
        return sortingLocalized
    }
    
    var body: some View {
        NavigationView {
            VStack{
                
                HStack{
                    Spacer()
                    Text("Sorting")
                    Text(localizedSortingKey()).foregroundColor(.blue)
                }.padding(.trailing, 16).padding(.top, 4).onTapGesture {
                    withAnimation{
                        showPicker.toggle()
                    }
                }
                
                if showPicker == true {
                    Picker("SortingBy", selection: $products.sorting) {
                        ForEach(sorting, id: \.self) {
                            Text(LocalizedStringKey($0))
                        }
                    }.onChange(of: products.sorting, perform: { value in
                        products.getProducts()
                    })
                    
                    Button(action: {
                        withAnimation{
                            showPicker = false
                        }
                    }) {
                        HStack{
                            Text("Done").foregroundColor(.blue)
                        }.frame(maxWidth: .infinity)
                    }
                }
                
                List {
                    ForEach(products.productList.indices, id: \.self) { i in
                        NavigationLink(destination: ProductDetails(products: products, productCategory: products.productCategories[i], productDate: products.productDates[i], productDetails: products.productDetails[i], productId: products.productIDs[i], productName: products.productList[i], productPhotoURL: products.productPhotoURL[i], productPrice: products.priceList[i], productStock: products.productStocks[i], productIndex: i)) {
                            HStack{
                                Text("\(products.productList[i])")
                                Spacer()
                                Text("₺\(products.priceList[i])")
                            }
                        }
                    }
                }
                
            }
            .navigationBarTitle(Text("ProductList"))
        }
    }
}
