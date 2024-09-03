import 'package:e_commerce_site_django/common/utils/enums.dart';
import 'package:e_commerce_site_django/common/utils/environment.dart';
import 'package:e_commerce_site_django/src/categories/hooks/results/categories_results.dart';
import 'package:e_commerce_site_django/src/categories/hooks/results/category_products_results.dart';
import 'package:e_commerce_site_django/src/categories/models/categories_model.dart';
import 'package:e_commerce_site_django/src/products/models/products_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProduct fetchProducts(QueryType queryType) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    Uri url;

    try {
      switch (queryType) {
        case QueryType.all:
          url = Uri.parse('${Environment.appBaseUrl}/api/products/');
          break;
        case QueryType.popular:
          url = Uri.parse('${Environment.appBaseUrl}/api/products/popular');
          break;
        case QueryType.unisex:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/products/byType/?clothesType=${queryType.name}');
          break;
        case QueryType.men:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/products/byType/?clothesType=${queryType.name}');
          break;
        case QueryType.women:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/products/byType/?clothesType=${queryType.name}');
          break;
        case QueryType.kids:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/products/byType/?clothesType=${queryType.name}');
          break;
      }
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
  },  [queryType.index]);

  void refetch() {
    isLoading.value = true;
    fetchData(); 
  }

  return FetchProduct(
      products: products.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
