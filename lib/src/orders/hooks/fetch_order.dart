import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/environment.dart';
import 'package:e_commerce_site_django/src/orders/hooks/results/fetch_order_results.dart';
import 'package:e_commerce_site_django/src/orders/models/orders_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchOrder fetchOrder(int id) {
  final order = useState<OrderModel?>(null);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/orders/single/?id=$id');
      String? accessToken = Storage().getString('accessToken');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": 'application/json',
          "Authorization": 'Token $accessToken'
        },
      );
      if (response.statusCode == 200) {
        order.value = ordersModelSingleFromJson(response.body);
        print("cart :${order.value}");
      }
    } catch (e) {
      error.value = e.toString();
      print("error: ${e.toString()}");
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
    print("Refetch has ran");
    fetchData();
  }

  return FetchOrder(
      order: order.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
