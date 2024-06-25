import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tezda_task/Models/product_model.dart';
import 'package:tezda_task/Utils/app_colors.dart';
import 'package:tezda_task/View/Home/widgets/product_details.dart';

import '../../../Providers/profile_provider.dart';

Widget productCard(ProductModel productModel, BuildContext context) {
  return Material(
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: productModel)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                return Product_image(
                  product: productModel,
                );
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              //height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      productModel.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),

                    Text("Price: £${productModel.price}",
                        style: GoogleFonts.poppins(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        )),
                    //SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class Product_image extends StatefulWidget {
  const Product_image({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<Product_image> createState() => _Product_imageState();
}

class _Product_imageState extends State<Product_image> {
  final _pageController = PageController();
  int _currentPage = 0;
  bool isFav = false;

  @override
  void initState() {
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    for (var element in pro.favList) {
      if (int.parse(element) == widget.product.id) {
        setState(() {
          isFav = true;
        });
        break;
      }
    }
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.product.id!,
      child: SizedBox(
        height: 150.h,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: PageView(
                controller: _pageController,
                children: widget.product.images!
                    .map((item) => Image.network(item, fit: BoxFit.cover))
                    .toList(),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 50.w,
              child: DotsIndicator(
                dotsCount: widget.product.images!.length,
                position: _currentPage,
                decorator: const DotsDecorator(
                  activeColor: primaryColor,
                  size: const Size.square(4.0),

                  // Active dot color
                ),
              ),
            ),
            Positioned(
                top: 5.w,
                right: 5.w,
                child: IconButton(
                  onPressed: () {
                    if (isFav) {
                      Provider.of<ProfileProvider>(context, listen: false)
                          .removeFromFavorites(widget.product.id.toString());
                      setState(() {
                        isFav = false;
                      });
                    } else {
                      Provider.of<ProfileProvider>(context, listen: false)
                          .addToFavorites(widget.product.id.toString());
                      setState(() {
                        isFav = true;
                      });
                    }
                  },
                  icon: Icon(
                    isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    color: Colors.deepOrange,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
