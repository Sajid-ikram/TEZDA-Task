import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as storage;

import '../Constants/api_endpoints.dart';
import '../Models/product_model.dart';

class ProductClient {
  ProductClient() {}

  Future<List<ProductModel>> getProducts(int offset) async {
    var url = Uri.parse(Api_Endpoints.PRODUCT + "?offset=$offset&limit=10");
    try {
      var response = await http.get(url);
      var listOfNotice = jsonDecode(response.body) as List;

      if (response.statusCode == 200) {
        return listOfNotice
            .map((element) => ProductModel.fromJson(element))
            .toList();
      } else {
        throw Exception("Fail To load");
      }
    } catch (err) {

      throw Exception(err);
    }
  }



 /* Future<List<ProductModel>> getProducts(int offset) async {
    //var url = Uri.parse(Api_Endpoints.PRODUCT + "?offset=$offset&limit=10");
    try {
      //var response = await http.get(url);

      await Future.delayed(Duration(seconds: 2));
      var response =
          '''[{"id":16,"title":"Classic White Tee - Timeless Style and Comfort","price":73,"description":"Elevate your everyday wardrobe with our Classic White Tee. Crafted from premium soft cotton material, this versatile t-shirt combines comfort with durability, perfect for daily wear. Featuring a relaxed, unisex fit that flatters every body type, it's a staple piece for any casual ensemble. Easy to care for and machine washable, this white tee retains its shape and softness wash after wash. Pair it with your favorite jeans or layer it under a jacket for a smart look.","images":["https://i.imgur.com/Y54Bt8J.jpeg","https://i.imgur.com/SZPDSgy.jpeg","https://i.imgur.com/sJv4Xx0.jpeg"],"creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z","category":{"id":1,"name":"Clothes","image":"https://i.imgur.com/QkIa5tT.jpeg","creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z"}},{"id":17,"title":"Classic Black T-Shirt","price":35,"description":"Elevate your everyday style with our Classic Black T-Shirt. This staple piece is crafted from soft, breathable cotton for all-day comfort. Its versatile design features a classic crew neck and short sleeves, making it perfect for layering or wearing on its own. Durable and easy to care for, it's sure to become a favorite in your wardrobe.","images":["https://i.imgur.com/9DqEOV5.jpeg","https://i.imgur.com/ae0AEYn.jpeg","https://i.imgur.com/mZ4rUjj.jpeg"],"creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z","category":{"id":1,"name":"Clothes","image":"https://i.imgur.com/QkIa5tT.jpeg","creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z"}},{"id":18,"title":"Sleek White & Orange Wireless Gaming Controller","price":69,"description":"Elevate your gaming experience with this state-of-the-art wireless controller, featuring a crisp white base with vibrant orange accents. Designed for precision play, the ergonomic shape and responsive buttons provide maximum comfort and control for endless hours of gameplay. Compatible with multiple gaming platforms, this controller is a must-have for any serious gamer looking to enhance their setup.","images":["https://i.imgur.com/ZANVnHE.jpeg","https://i.imgur.com/Ro5z6Tn.jpeg","https://i.imgur.com/woA93Li.jpeg"],"creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z","category":{"id":2,"name":"Electronics","image":"https://i.imgur.com/ZANVnHE.jpeg","creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z"}},{"id":19,"title":"Sleek Wireless Headphone & Inked Earbud Set","price":44,"description":"Experience the fusion of style and sound with this sophisticated audio set featuring a pair of sleek, white wireless headphones offering crystal-clear sound quality and over-ear comfort. The set also includes a set of durable earbuds, perfect for an on-the-go lifestyle. Elevate your music enjoyment with this versatile duo, designed to cater to all your listening needs.","images":["https://i.imgur.com/yVeIeDa.jpeg","https://i.imgur.com/jByJ4ih.jpeg","https://i.imgur.com/KXj6Tpb.jpeg"],"creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z","category":{"id":2,"name":"Electronics","image":"https://i.imgur.com/ZANVnHE.jpeg","creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z"}},{"id":20,"title":"Sleek Comfort-Fit Over-Ear Headphones","price":28,"description":"Experience superior sound quality with our Sleek Comfort-Fit Over-Ear Headphones, designed for prolonged use with cushioned ear cups and an adjustable, padded headband. Ideal for immersive listening, whether you're at home, in the office, or on the move. Their durable construction and timeless design provide both aesthetically pleasing looks and long-lasting performance.","images":["https://i.imgur.com/SolkFEB.jpeg","https://i.imgur.com/KIGW49u.jpeg","https://i.imgur.com/mWwek7p.jpeg"],"creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z","category":{"id":2,"name":"Electronics","image":"https://i.imgur.com/ZANVnHE.jpeg","creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z"}},{"id":21,"title":"Efficient 2-Slice Toaster","price":48,"description":"Enhance your morning routine with our sleek 2-slice toaster, featuring adjustable browning controls and a removable crumb tray for easy cleaning. This compact and stylish appliance is perfect for any kitchen, ensuring your toast is always golden brown and delicious.","images":["https://i.imgur.com/keVCVIa.jpeg","https://i.imgur.com/afHY7v2.jpeg","https://i.imgur.com/yAOihUe.jpeg"],"creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z","category":{"id":2,"name":"Electronics","image":"https://i.imgur.com/ZANVnHE.jpeg","creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z"}},{"id":22,"title":"Sleek Wireless Computer Mouse","price":10,"description":"Experience smooth and precise navigation with this modern wireless mouse, featuring a glossy finish and a comfortable ergonomic design. Its responsive tracking and easy-to-use interface make it the perfect accessory for any desktop or laptop setup. The stylish blue hue adds a splash of color to your workspace, while its compact size ensures it fits neatly in your bag for on-the-go productivity.","images":["https://i.imgur.com/w3Y8NwQ.jpeg","https://i.imgur.com/WJFOGIC.jpeg","https://i.imgur.com/dV4Nklf.jpeg"],"creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z","category":{"id":2,"name":"Electronics","image":"https://i.imgur.com/ZANVnHE.jpeg","creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z"}},{"id":23,"title":"Sleek Modern Laptop with Ambient Lighting","price":43,"description":"Experience next-level computing with our ultra-slim laptop, featuring a stunning display illuminated by ambient lighting. This high-performance machine is perfect for both work and play, delivering powerful processing in a sleek, portable design. The vibrant colors add a touch of personality to your tech collection, making it as stylish as it is functional.","images":["https://i.imgur.com/OKn1KFI.jpeg","https://i.imgur.com/G4f21Ai.jpeg","https://i.imgur.com/Z9oKRVJ.jpeg"],"creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z","category":{"id":2,"name":"Electronics","image":"https://i.imgur.com/ZANVnHE.jpeg","creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z"}},{"id":24,"title":"Sleek Modern Laptop for Professionals","price":97,"description":"Experience cutting-edge technology and elegant design with our latest laptop model. Perfect for professionals on-the-go, this high-performance laptop boasts a powerful processor, ample storage, and a long-lasting battery life, all encased in a lightweight, slim frame for ultimate portability. Shop now to elevate your work and play.","images":["https://i.imgur.com/ItHcq7o.jpeg","https://i.imgur.com/55GM3XZ.jpeg","https://i.imgur.com/tcNJxoW.jpeg"],"creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z","category":{"id":2,"name":"Electronics","image":"https://i.imgur.com/ZANVnHE.jpeg","creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z"}},{"id":25,"title":"Stylish Red & Silver Over-Ear Headphones","price":39,"description":"Immerse yourself in superior sound quality with these sleek red and silver over-ear headphones. Designed for comfort and style, the headphones feature cushioned ear cups, an adjustable padded headband, and a detachable red cable for easy storage and portability. Perfect for music lovers and audiophiles who value both appearance and audio fidelity.","images":["https://i.imgur.com/YaSqa06.jpeg","https://i.imgur.com/isQAliJ.jpeg","https://i.imgur.com/5B8UQfh.jpeg"],"creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z","category":{"id":2,"name":"Electronics","image":"https://i.imgur.com/ZANVnHE.jpeg","creationAt":"2024-06-25T12:43:04.000Z","updatedAt":"2024-06-25T12:43:04.000Z"}}] ''';
      var listOfNotice = jsonDecode(response);

      // print(url);
      if (*//*response.statusCode == 200*//* true) {
        return listOfNotice
            .map<ProductModel>((element) => ProductModel.fromJson(element))
            .toList();
      } else {
        throw Exception("Fail To load");
      }
    } catch (err) {
      throw Exception(err);
    }
  }*/
}
