//
//  ProductDetails.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 5.03.2021.
//

import SwiftUI
import FirebaseStorage
import FirebaseDatabase

struct ProductDetails: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var products: GetProducts
    
    @State var productCategory: Int
    @State var productDate: String
    @State var productDetails: String
    @State var productId: String
    @State var productName: String
    @State var productPhotoURL: String
    @State var productPrice: String
    @State var productStock: Int
    
    @State var productIndex: Int
    
    @State var productImage: UIImage!
    
    private let database = Database.database().reference()
    
    @State private var categories = ["Art", "Electronics", "Fashion", "Health", "Home", "Sports", "Tools & Equipment"]
    
    @State private var showingAlert = false
    
    //Getting the image from Firebase Storage URL
    func getPicture() {
        let url = URL(string: productPhotoURL)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                withAnimation{
                    self.productImage = image
                }
            }
        })
        
        task.resume()
    }
    
    //Converting the image data to showable image
    func convertImage() -> Image {
        let image = Image(uiImage: productImage)
        return image
    }
    
    //Deleting product from Firebase Database
    func deleteProduct() {
        database.child("Products").child(products.productIDs[productIndex]).removeValue()
        
        //Screen pop
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        GeometryReader {
            geometry in
            
            VStack{
                VStack{
                    if productImage != nil {
                        Image(uiImage: productImage).resizable()
                    } else {
                        ProgressView()
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height / 2, alignment: .center).padding(.top, 8)

                VStack(spacing: 4){
                    HStack{
                        Text("Name")
                        Text("\(productName)")
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("Date")
                        Text("\(productDate)")
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("Details")
                        Text("\(productDetails)")
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("Price2")
                        Text("\(productPrice)")
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("Stock")
                        Text("\(productStock)")
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("Category")
                        Text(LocalizedStringKey(categories[productCategory]))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }.padding(.top, 16).padding(.leading, 16)
        
                if productImage != nil {
                    HStack(spacing: 128){
                        NavigationLink(destination: EditProduct(inputImage: productImage, productCategory: productCategory, productDetails: productDetails, productId: productId, productName: productName, productPhotoURL: productPhotoURL, productPrice: productPrice, productStock: productStock, productImage: convertImage())) {
                                Text("Edit").foregroundColor(.blue)
                        }
                        
                        Button(action: {
                            showingAlert = true
                        }) {
                            Text("Delete").foregroundColor(.red)
                        }
                        .alert(isPresented:$showingAlert) {
                            Alert(
                                title: Text("AreYouSureDeleting"),
                                message: Text("CannotUndone"),
                                primaryButton: .destructive(Text("Delete")) {
                                    deleteProduct()
                                },
                                secondaryButton: .cancel(Text("Cancel")) {
                                    showingAlert = false
                                }
                            )
                        }
                    }.padding(.top, 16)
                }
                
            }.onAppear(perform: getPicture)
            .navigationBarTitle(Text("\(productName)"))
        }
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(products: GetProducts(), productCategory: 0, productDate: "01/01/1970", productDetails: "preview", productId: "123456abc", productName: "preview", productPhotoURL: "randomUrl", productPrice: "0000", productStock: 1, productIndex: 1)
    }
}
