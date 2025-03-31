import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/models/product_model.dart';

class ProductServices extends ClientBase {
  Future<List<ProductModel>> getProducts() async {
    final response = await clientDio.get('/products');
    final List<dynamic> data = response.data;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}
