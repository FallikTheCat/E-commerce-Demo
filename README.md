# MobirollerApp / EN

MobirollerApp is an e-commerce demo application that I developed for Mobiroller company. The application allows you to add, sort and organize products in various categories.

This app uses Firebase Realtime-Database, Firebase Storage and Firebase Cloud-Functions.

### Features

* Add new products from 7 different categories to the database with their name, details, price, stock and photo.
* You can browse the products you added from the product list.
* You can sort the product list in 5 different ways. (Name, Category, Stock, Price High to Low and Price Low to High).
* You can click on the product you want and access the product details.
* You can delete or edit the product on the product detail page.

### Architecture

The application's design pattern is the MVVM model that comes built-in with SwiftUI.
* ProductInfo is the data container of the products. Which is a "Model" for this application.
* GetProducts and ImagePicker files are the "ViewModel"s. These files encapsulate business logic and allow Views to observe state changes.
* AddNewProductView, EditProduct, ProductDetails and ProductsView files are my "View"s.

# MobirollerApp / TR

MobirollerApp bir e-ticaret demo uygulamasıdır. Uygulama içinden farklı kategorilerden ürünler eklemenizi, sıralamanızı ve düzenleyebilmenizi sağlar.

Bu uygulamada Firebase Realtime-Database, Firebase Storage ve Firebase Cloud-Functions kullanıldı.

### Özellikler

* 7 farklı kategoriden istediğiniz ürünleri ismi, detayları, fiyatı, stoğu ve fotoğrafıyla birlikte veritabanına yükleyebilirsiniz.
* Eklediğiniz ürünlere ürün listesinden göz atabilirsiniz.
* Ürün listesini 5 farklı şekilde sıralayabilirsiniz. (İsme, Kategoriye, Stoğa, Fiyat çoktan aza ve Fiyat azdan çoğa).
* İstediğiniz ürüne tıklayıp ürün detaylarına ulaşabilirsiniz.
* Ürün detay sayfasında ürünü silebilir veya düzenleyebilirsiniz.


### Mimari

Uygulamanın dizayn mimarisi, SwiftUI ile birlikte gelen MVVM modelidir.
* ProductInfo ürünlerin verilerinin tutulduğu yer. Bu dosya uygulamanın "Model" kısmı.
* GetProducts ve ImagePicker dosyaları "ViewModel"lerim. Bu dosyalarda doğru yerde çalışması gereken fonksiyonlar ve verilerin ayrılması gibi işlemlerimi gerçekleştiriyorum.
Ayrıca View'lar bu dosyalardaki durumlara göre şekilleniyor.
* AddNewProductView, EditProduct, ProductDetails and ProductsView dosyaları ise "View"lardan oluşuyor.
