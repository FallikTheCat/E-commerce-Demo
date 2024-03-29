//
//  EditProduct.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 8.03.2021.
//

import SwiftUI
import FirebaseDatabase
import FirebaseStorage

struct EditProduct: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    private let storage = Storage.storage().reference()
    private let database = Database.database().reference()
    
    @State private var showingImagePicker = false
    
    @State private var loading = false
    @State private var showAlert = false
    @State var inputImage: UIImage?
    
    @State var productCategory: Int
    @State var productDetails: String
    @State var productId: String
    @State var productName: String
    @State var productPhotoURL: String
    @State var productPrice: Int
    @State var productStock: Int
    
    @State var productImage: Image?
    
    @State private var categories = ["Art", "Electronics", "Fashion", "Health", "Home", "Sports", "Tools"]
    
    @State private var stringPrice = ""
    
    //Converting price value to String to Int
    func priceStringToInt() {
        let priceInt = Int(stringPrice)
        productPrice = priceInt!
    }
    
    func priceToString() {
        let priceToString = String(productPrice)
        stringPrice = priceToString
    }
    
    //Getting the image from photo library
    func loadImage() {
        guard let inputImage = inputImage else {return}
        productImage = Image(uiImage: inputImage)
    }
    
    //Converting current date format to string
    let currentDate: String = {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateToString = dateFormatter.string(from: date)
        return dateToString
    }()
    
    //Writing the data to Firebase Realtime-Database and put the product image to the Firebase Storage
    func addNewProduct() {
        
        withAnimation{
            loading = true
        }
        
        //Converting image to data
        let imageData = (inputImage?.pngData())!
        
        //Storing data to Firebase Storage
        storage.child("images/\(productId).png").putData(imageData, metadata: nil, completion: {
            _, error in
            
            guard error == nil else {
                print("Failed to upload image")
                return
            }
            
            //Getting download URL
            self.storage.child("images/\(productId).png").downloadURL(completion: { [self]
                url, error in
                
                guard let url = url, error == nil else {
                    print("Failed to get downloadURL")
                    return
                }
                
                let urlString = url.absoluteString
                print("Download URL: \(urlString)")
                
                
                let productInfo: [String: Any] = [
                    "category": productCategory,
                    "date": currentDate,
                    "details": productDetails,
                    "name": productName,
                    "price": productPrice,
                    "stock": productStock,
                    "photoURL": urlString
                ]
                
                database.child("Products").child("\(productId)").setValue(productInfo)
                
                showAlert = true
                loading = false
                
                presentationMode.wrappedValue.dismiss()
                presentationMode.wrappedValue.dismiss()
            })
        })
        
    }
    
    var body: some View {
        
            Form {
                Picker(selection: $productCategory, label: Text("SelectCategory")) {
                    ForEach(0 ..< categories.count) {
                        Text(LocalizedStringKey(categories[$0])).tag($0)
                    }
                }
                
                Stepper(value: $productStock, in: 1...100) {
                    HStack{
                        Text("InStock")
                        Text("\(productStock)")
                    }
                }
                
                Section {
                    TextField("ProductName", text: $productName)
                    HStack{
                        Text("₺")
                        TextField("Price", text: $stringPrice).onChange(of: stringPrice, perform: { value in
                            priceStringToInt()
                        })
                    }.onAppear(perform: priceToString)
                }
                
                Section {
                    HStack{
                        Text("Details")
                        TextEditor(text: $productDetails)
                    }
                }
                
                Section {
                    HStack{
                        if productImage != nil {
                            productImage?.resizable().scaledToFit()
                        } else {
                            Text("AddPicture").foregroundColor(.blue).frame(maxWidth: .infinity)
                        }
                    }.onTapGesture {
                        self.showingImagePicker = true
                    }
                }
                
                Section {
                    HStack{
                        if loading == true {
                            ProgressView()
                        }
                        Button(action: {
                            addNewProduct()
                        }) {
                            Text("Done").padding(.leading, 15)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("EditProduct"))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success2"), dismissButton: .default(Text("Okay")))
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
    }
}

struct EditProduct_Previews: PreviewProvider {
    static var previews: some View {
        EditProduct(productCategory: 0, productDetails: "preview", productId: "123456abc", productName: "preview", productPhotoURL: "randomUrl", productPrice: 0000, productStock: 1)
    }
}
