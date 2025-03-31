import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/models/product_model.dart';
import 'package:proyecto_final/services/product_services.dart';

final productServiceProvider =
    Provider<ProductServices>((ref) => ProductServices());

final productsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final productService = ref.read(productServiceProvider);
  return await productService.getProducts();
});
