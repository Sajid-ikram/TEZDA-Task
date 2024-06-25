import '../Models/product_model.dart';
import '../client/product_client.dart';

class ProductRepo {
  static final ProductRepo _instance = ProductRepo();
  ProductClient? _noticeClient;

  ProductClient getNoticeClient() {
    _noticeClient ??= ProductClient();
    return _noticeClient!;
  }

  void initializeClient() {
    _noticeClient = ProductClient();
  }

  static ProductRepo get instance => _instance;


  Future<List<ProductModel>> getNotices(int skip) async {
    try {
      List<ProductModel> response =
          await ProductRepo.instance.getNoticeClient().getProducts(skip);

      return response;
    } catch (err) {print("********************------------------");
      print(err);
      throw Exception("Something went wrong");
    }
  }


}
