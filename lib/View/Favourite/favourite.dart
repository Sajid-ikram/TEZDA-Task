import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:tezda_task/Models/product_model.dart';
import 'package:tezda_task/Utils/app_colors.dart';

import '../../Constants/api_endpoints.dart';
import '../../Providers/profile_provider.dart';
import '../../Utils/custom_loading.dart';
import '../Home/widgets/card.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  Future<List<dynamic>> fetchFavourites(List<String> favList) async {
    List<ProductModel> favouriteItems = [];

    for (String id in favList) {
      final response =
          await http.get(Uri.parse(Api_Endpoints.PRODUCT + "/$id"));

      print(response.body);
      print(response.statusCode);
      print(
          "++++++++++++++++++++++++++++++++++++++++++++++++++++++ response.statusCode");
      if (response.statusCode == 200) {
        favouriteItems.add(ProductModel.fromJson(jsonDecode(response.body)));
      } else {
        throw Exception('Failed to load item');
      }
    }

    return favouriteItems;
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final favList = profileProvider.favList;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
        centerTitle: true,
        leading: null,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchFavourites(favList),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(child: Text("No Favourites"));
            }

            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 60),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.77,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return productCard(snapshot.data![index], context);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          // By default, show a loading spinner.
          return buildThreeInOutLoadingWidget();
        },
      ),
    );
  }
}
