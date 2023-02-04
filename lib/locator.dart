import 'package:customer/core/service/auth_service.dart';
import 'package:customer/core/service/location_service.dart';
import 'package:customer/core/service/notification_service.dart';
import 'package:customer/core/service/promotion_service.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/location_view.dart';
import 'package:customer/core/view/notification_view.dart';
import 'package:customer/core/view/promotion_view.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthView());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => NotificationView());
  locator.registerLazySingleton(() => PromotionService());
  locator.registerLazySingleton(() => PromotionView());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => LocationView());
}
