import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tezda_task/View/Home/widgets/card.dart';
import '../../Models/product_model.dart';
import '../../Providers/profile_provider.dart';
import '../../Repository/product_repo.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/custom_loading.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController scrollController;
  bool isLoading = false;
  bool hasMore = true;
  List<ProductModel> listOfProduct = [];

  @override
  void initState() {
    super.initState();
    getData(false);

    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.95 &&
          !isLoading) {
        if (hasMore) {
          getData(false);
        }
      }
    });
  }

  getData(bool refresh) async {
    if (refresh) {
      hasMore = true;
      listOfProduct.clear();
    }
    setState(() {
      isLoading = true;
    });
    var response = await ProductRepo().getNotices(listOfProduct.length);
    listOfProduct.addAll(response);
    setState(() {
      isLoading = false;
      hasMore = response.isNotEmpty;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEZDA",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
        centerTitle: true,
        leading: null,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (pro.role == "admin")
            IconButton(
              padding: EdgeInsets.only(right: 20.w),
              onPressed: () {
                Navigator.of(context).pushNamed("AddNotice");
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          GridView.builder(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 90),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.77,
            ),
            itemCount: listOfProduct.length,
            itemBuilder: (BuildContext context, int index) {
              return productCard(listOfProduct[index], context);
            },
          ),
          if (isLoading)
            Positioned(
              left: 0,
              bottom: listOfProduct.isEmpty ? null : 70,
              top: listOfProduct.isEmpty ? 300 : null,
              right: 0,
              child: Center(
                child: buildThreeInOutLoadingWidget(),
              ),
            ),
        ],
      ),
    );
  }
}
