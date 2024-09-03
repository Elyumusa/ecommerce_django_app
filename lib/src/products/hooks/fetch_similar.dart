import 'package:e_commerce_site_django/common/utils/environment.dart';
import 'package:e_commerce_site_django/src/categories/hooks/results/categories_results.dart';
import 'package:e_commerce_site_django/src/categories/hooks/results/category_products_results.dart';
import 'package:e_commerce_site_django/src/categories/models/categories_model.dart';
import 'package:e_commerce_site_django/src/products/models/products_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProduct fetchSimilar(int category_id) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/products/recommendations/?category=$category_id');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        products.value = productsFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
  }

  return FetchProduct(
      products: products.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
