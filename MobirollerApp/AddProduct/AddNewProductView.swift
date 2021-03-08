//
//  AddNewProductView.swift
//  MobirollerApp
//
//  Created by Baturay Koç on 4.03.2021.
//

import SwiftUI
import FirebaseDatabase
import FirebaseStorage

struct AddNewProductView: View {
    
    private let storage = Storage.storage().reference()
    private let database = Database.database().reference()
    
    @ObservedObject var products: GetProducts
    @ObservedObject var product = ProductInfo()
    
    @State private var showingImagePicker = false
    
    @State private var loading = false
    @State private var showAlert = false
    @State private var inputImage: UIImage?
    
    //Creating a unique id for the product
    let uuid = UUID().uuidString
    
    //Converting current date format to string
    let currentDate: String = {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateToString = dateFormatter.string(from: date)
        return dateToString
    }()
    
    //Checking if all information has been entered
    var isValid: Bool {
        if $product.productName.wrappedValue == "" || $product.productDetails.wrappedValue == "" || $product.productPrice.wrappedValue == "" || product.productImage == nil {
            return false
        }
        
        return true
    }
    
    //Getting the image from photo library
    func loadImage() {
        guard let inputImage = inputImage else {return}
        product.productImage = Image(uiImage: inputImage)
    }
    
    //Writing the data to Firebase Realtime-Database and put the product image to the Firebase Storage
    func addNewProduct() {
        
        withAnimation{
            loading = true
        }
        
        //Converting image to data
        let imageData = (inputImage?.pngData())!
        
        //Storing data to Firebase Storage
        storage.child("images/\(uuid).png").putData(imageData, metadata: nil, completion: {
            _, error in
            
            guard error == nil else {
                print("Failed to upload image")
                return
            }
            
            //Getting download URL
            self.storage.child("images/\(uuid).png").downloadURL(completion: { [self]
                url, error in
                
                guard let url = url, error == nil else {
                    print("Failed to get downloadURL")
                    return
                }
                
                let urlString = url.absoluteString
                print("Download URL: \(urlString)")
                
                
                let productInfo: [String: Any] = [
                    "category": $product.category.wrappedValue,
                    "date": currentDate,
                    "details": $product.productDetails.wrappedValue,
                    "name": $product.productName.wrappedValue,
                    "price": $product.productPrice.wrappedValue,
                    "stock": $product.stock.wrappedValue,
                    "photoURL": urlString,
                    "timestamp": Int(Date().timeIntervalSince1970 * 1000000)
                ]
                
                database.child("Products").child("\(uuid)").setValue(productInfo)
                
                showAlert = true
                loading = false
            })
        })
        
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Picker(selection: $product.category, label: Text("SelectCategory")) {
                    ForEach(0 ..< ProductInfo.categories.count) {
                        Text(ProductInfo.categories[$0]).tag($0)
                    }
                }
                
                Stepper(value: $product.stock, in: 1...100) {
                    HStack{
                        Text("InStock")
                        Text("\(product.stock)")
                    }
                }
                
                Section {
                    TextField("ProductName", text: $product.productName)
                    HStack{
                        Text("₺")
                        TextField("Price", text: $product.productPrice)
                    }
                }
                
                Section {
                    HStack{
                        Text("Details")
                        TextEditor(text: $product.productDetails)
                    }
                }
                
                Section {
                    HStack{
                        if product.productImage != nil {
                            product.productImage?.resizable().scaledToFit()
                        } else {
                            Text("AddPicture")
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
                            Text("AddProduct").padding(.leading, 15)
                        }
                    }.disabled(!isValid)
                }
            }
            .navigationBarTitle(Text("AddNewProduct"))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"), dismissButton: .default(Text("Okay")))
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }
}
