# MobirollerApp / EN

MobirollerApp is an e-commerce demo application that I developed for Mobiroller. The application allows you to add, sort and organize products in various categories.

This app uses **Firebase Realtime-Database, Firebase Storage** and **Firebase Cloud-Functions**.

### Features

* Add new products from 7 different categories to the database with their name, details, price, stock and a photo.
* You can browse the products you added from the product list.
* You can sort the product list in 5 different ways. *(Name, Category, Stock, Price High to Low and Price Low to High).*
* You can click on the product you want and access the product details.
* You can delete or edit the product on the product detail page.

### Architecture

The application's design pattern is the **MVVM** model that comes built-in with SwiftUI.

#### Models
* `ProductInfo` is the data container of the products. Which is a **Model** for this application.
* `ProductInfo` has the variables of the products.

#### ViewModels
* `GetProducts` and `ImagePicker` files are the **ViewModel**'s. 
* These files encapsulate business logic and allow Views to observe state changes.
* When the View appears on the screen, the onAppear callback calls ***getProducts()*** on the `GetProducts` ViewModel, triggering the Database call for loading the data.

#### Views
* `AddNewProductView`, `EditProduct`, `ProductDetails` and `ProductsView` files are my **View**'s.
* `ProductsView`, the page listing the products in the Database. On this page, a listing is made according to the data such as the incoming product list or the sort order in the `GetProducts` ViewModel.
* `AddNewProductView` contains the form on the page where the new product will be added.
* `ProductDetails`, the page showing the details of the clicked product.
* `EditProduct` is the product edit page. Here, the editing of the selected product is made with the data we have previously taken.

# MobirollerApp / TR

MobirollerApp bir e-ticaret demo uygulamasıdır. Uygulama içinden farklı kategorilerden ürünler eklemenizi, sıralamanızı ve düzenleyebilmenizi sağlar.

Bu uygulamada **Firebase Realtime-Database, Firebase Storage** ve **Firebase Cloud-Functions** kullanıldı.

### Özellikler

* 7 farklı kategoriden istediğiniz ürünleri ismi, detayları, fiyatı, stoğu ve fotoğrafıyla birlikte veritabanına yükleyebilirsiniz.
* Eklediğiniz ürünlere ürün listesinden göz atabilirsiniz.
* Ürün listesini 5 farklı şekilde sıralayabilirsiniz. *(İsme, Kategoriye, Stoğa, Fiyat çoktan aza ve Fiyat azdan çoğa).*
* İstediğiniz ürüne tıklayıp ürün detaylarına ulaşabilirsiniz.
* Ürün detay sayfasında ürünü silebilir veya düzenleyebilirsiniz.


### Mimari

Uygulamanın dizayn mimarisi, SwiftUI ile birlikte gelen **MVVM** modelidir.

#### Models
* `ProductInfo` ürünlerin verilerinin tutulduğu yer. Bu dosya uygulamanın **Model** kısmı.
* `ProductInfo`'da ürünlerin değerleri bulunuyor.

#### ViewModels
* `GetProducts` ve `ImagePicker` dosyaları **ViewModel**'lerim. 
* Bu dosyalarda doğru yerde çalışması gereken fonksiyonlar ve verilerin ayrılması gibi işlemlerimi gerçekleştiriyorum.
Ayrıca View'lar bu dosyalardaki durumlara göre şekilleniyor.
* Viewlar sayfaya yüklendiğinde, onAppear methodu ile ***getProducts()*** fonksiyonu tetikleniyor ve Database'deki veriler Viewlara aktarılıyor.

#### Views
* `AddNewProductView`, `EditProduct`, `ProductDetails` and `ProductsView` dosyaları ise **View**'lardan oluşuyor.
* `ProductsView`, Database'deki ürünlerin listelendiği sayfa. Bu sayfada `GetProducts` ViewModel'indeki gelen ürün listesi, sıralama şekli gibi verilere göre listeleme yapılıyor.
* `AddNewProductView`, yeni ürünün ekleneceği sayfadaki formu içeriyor.
* `ProductDetails`, tıklanan ürünün detaylarının görüldüğü sayfa.
* `EditProduct` ise ürün düzenleme sayfası. Burada daha önce çektiğimiz verilerle seçilen ürünün düzenlemesi yapılıyor.
