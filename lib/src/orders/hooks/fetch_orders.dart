import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/enums.dart';
import 'package:e_commerce_site_django/common/utils/environment.dart';
import 'package:e_commerce_site_django/src/orders/hooks/results/fetch_order_results.dart';
import 'package:e_commerce_site_django/src/orders/hooks/results/fetch_orders_result.dart';
import 'package:e_commerce_site_django/src/orders/models/orders_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchOrders fetchOrders(FetchOrdersTypes o) {
  final order = useState<List<OrderModel?>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  Uri url = Uri.parse("");
  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      switch (o) {
        case FetchOrdersTypes.pending:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/orders/me/?status=Pending');
          break;
        case FetchOrdersTypes.delivered:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/orders/me/?status=Deliverd');
          break;
        case FetchOrdersTypes.cancelled:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/orders/me/?status=Cancelled');
          break;
        default:
      }
      String? accessToken = Storage().getString('accessToken');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": 'application/json',
          "Authorization": 'Token $accessToken'
        },
      );
      if (response.statusCode == 200) {
        order.value = orderModelFromJson(response.body);
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
  }, [o.index]);

  void refetch() {
    isLoading.value = true;
    print("Refetch has ran");
    fetchData();
  }

  return FetchOrders(
      orders: order.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
