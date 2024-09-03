import 'package:e_commerce_site_django/common/services/storage.dart';
import 'package:e_commerce_site_django/common/utils/environment.dart';
import 'package:e_commerce_site_django/src/cart/controllers/cart_notifier.dart';
import 'package:e_commerce_site_django/src/notifications/controllers/notification_notifier.dart';
import 'package:e_commerce_site_django/src/notifications/hooks/results/count_results.dart';
import 'package:e_commerce_site_django/src/notifications/hooks/results/notifications_results.dart';
import 'package:e_commerce_site_django/src/notifications/models/notification_count.dart';
import 'package:e_commerce_site_django/src/notifications/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

FetchNotifications fetchNotifications(BuildContext context) {
  final notifications = useState<List<NotificationModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  final accessToken = Storage().getString('accessToken');
  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/notifications/me/');
      final response = await http.get(url, headers: {
        'Authorization': 'Token $accessToken',
        'Content-Type': 'application/json'
      });
      if (response.statusCode == 200) {
        notifications.value = notificationModelFromJson(response.body);
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
    fetchData();
  }

  context.read<NotificationNotifier>().setRefetch(refetch);

  return FetchNotifications(
      notifications: notifications.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
