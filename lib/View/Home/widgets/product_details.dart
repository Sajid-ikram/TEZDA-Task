import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tezda_task/Models/product_model.dart';
import 'package:tezda_task/Utils/app_colors.dart';

import '../../Auth/widgets/custom_button.dart';
import '../../Auth/widgets/snackBar.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.product.id!,
              child: Stack(
                children: [
                  SizedBox(
                    height: 400,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return PhotoView(
                              imageProvider: NetworkImage(
                                  widget.product.images![_currentPage]),
                            );
                          }),
                        );
                      },
                      child: PageView(
                        controller: _pageController,
                        children: widget.product.images!
                            .map((item) =>
                                Image.network(item, fit: BoxFit.cover))
                            .toList(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 150.w,
                    child: DotsIndicator(
                      dotsCount: widget.product.images!.length,
                      position: _currentPage,
                      decorator: const DotsDecorator(
                        activeColor: primaryColor,
                        // Active dot color
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40.w,
                    left: 30.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.product.title!,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            buildText("£${widget.product.price.toString()}", "Price"),
            buildText(widget.product.category?.name ?? "", "Category"),
            buildText(widget.product.description!, "Description"),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  snackBar(context, "Not implemented yet!");
                },
                child: customButton("Add to Cart"),
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Align buildText(String text, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: title + ": ",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              TextSpan(
                  text: text,
                  style: TextStyle(fontSize: 16.sp, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
