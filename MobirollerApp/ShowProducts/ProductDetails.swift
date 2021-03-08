//
//  ProductDetails.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 5.03.2021.
//

import SwiftUI
import FirebaseStorage

struct ProductDetails: View {
    
    @State var productCategory: Int
    @State var productDate: String
    @State var productDetails: String
    @State var productId: String
    @State var productName: String
    @State var productPhotoURL: String
    @State var productPrice: String
    @State var productStock: Int
    
    @State var productImage: UIImage!
    
    @State private var categories = ["Art", "Electronics", "Fashion", "Health", "Home", "Sports", "Tools & Equipment"]
    
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
    
    func convertImage() -> Image {
        let image = Image(uiImage: productImage)
        return image
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
                    }
                    HStack{
                        Text("Date")
                        Text("\(productDate)")
                    }
                    HStack{
                        Text("Details")
                        Text("\(productDetails)")
                    }
                    HStack{
                        Text("Price2")
                        Text("\(productPrice)")
                    }
                    HStack{
                        Text("Stock")
                        Text("\(productStock)")
                    }
                    HStack{
                        Text("Category")
                        Text("\(productCategory)")
                    }
                }.padding(.top, 16)
        
                if productImage != nil {
                    NavigationLink(destination: EditProduct(inputImage: productImage, productCategory: productCategory, productDetails: productDetails, productId: productId, productName: productName, productPhotoURL: productPhotoURL, productPrice: productPrice, productStock: productStock, productImage: convertImage())) {
                            Text("Edit").foregroundColor(.blue)
                    }.padding(.top, 16)
                }
                
            }.onAppear(perform: getPicture)
            .navigationBarTitle(Text("\(productName)"))
        }
    }
}
