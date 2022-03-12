// ignore_for_file: deprecated_member_use
import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/CategoryNameProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Views/AboutUs.dart';
import 'package:multi_vendor_customer/Views/CartScreen.dart';
import 'package:multi_vendor_customer/Views/CategorySubScreen.dart';
import 'package:multi_vendor_customer/Views/HomeScreen.dart';
import 'package:multi_vendor_customer/Views/LoadScreen.dart';
import 'package:multi_vendor_customer/Views/LoginScreen.dart';
import 'package:multi_vendor_customer/Views/MyAccount.dart';
import 'package:multi_vendor_customer/Views/MyOrder.dart';
import 'package:multi_vendor_customer/Views/SearchScreen.dart';
import 'package:multi_vendor_customer/Views/policy_pages/privacy_policy.dart';
import 'package:multi_vendor_customer/Views/policy_pages/refund_policy.dart';
import 'package:multi_vendor_customer/Views/policy_pages/terms_of_service.dart';
import 'package:provider/provider.dart';

import 'Data/Models/OrderDataModel.dart';
import 'Utils/SharedPrefs.dart';
import 'Views/OrderDetails.dart';
import 'Views/ProductDetail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => VendorModelWrapper()),
      ChangeNotifierProvider(create: (_) => CartDataWrapper()),
      ChangeNotifierProvider(create: (_) => CustomColor()),
      ChangeNotifierProvider(create: (_) => CategoryName()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        accentColor: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            textTheme: TextTheme(
                headline6: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: "Poppins")),
            actionsIconTheme: IconThemeData(
                color:
                    Provider.of<CustomColor>(context).appPrimaryMaterialColor)),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: Colors.grey.shade600,
              backgroundColor: Colors.white,
              textStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              side: BorderSide(width: 1.2, color: Colors.grey.shade700)
              //backgroundColor: Colors.green,
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
            elevation: 0,
            textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
                fontSize: 15),
          ),
        ),
        fontFamily: 'Poppins',
        primaryColor: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
        primarySwatch:
            Provider.of<CustomColor>(context).appPrimaryMaterialColor,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }

  var _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
          // path: '/' + window.localStorage["storeId"]!,
          //path: '/' + sharedPrefs.storeLink,
          path: "/" +
              Uri.parse(window.location.href)
                  .path
                  .substring(1)
                  .split('/')
                  .first,
          pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: Loading(),
              ),
          routes: [
            // GoRoute(
            //     path: PageCollection.home,
            //     name: "home",
            //     pageBuilder: (context, state) => MaterialPage<void>(
            //           key: state.pageKey,
            //           child: HomeScreen(),
            //         ),
            //     routes: [
            //
            //     ]),
            GoRoute(
                path: PageCollection.categories + '/:Cid',
                pageBuilder: (context, state) {
                  final categoryId = state.params["Cid"];
                  return MaterialPage<void>(
                    key: state.pageKey,
                    child: CategorySubScreen(
                      categoryId: categoryId!,
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: PageCollection.product + '/:Pid',
                    pageBuilder: (context, state) {
                      final productId = state.params["Pid"];
                      return MaterialPage<void>(
                        key: state.pageKey,
                        child: ProductDescription(productId: productId!),
                      );
                    },
                  ),
                ]),
            GoRoute(
              path: PageCollection.product + '/:Pid',
              pageBuilder: (context, state) {
                final productId = state.params["Pid"];
                return MaterialPage<void>(
                  key: state.pageKey,
                  child: ProductDescription(productId: productId!),
                );
              },
            ),
            GoRoute(
              path: PageCollection.search,
              name: "search",
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: Search(),
              ),
            ),
            GoRoute(
              path: PageCollection.cart,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: CartScreen(),
              ),
            ),
            GoRoute(
              path: PageCollection.about_us,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: AboutUs(),
              ),
            ),
            GoRoute(
              path: PageCollection.login,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: LoginScreen(),
              ),
            ),
            GoRoute(
                path: PageCollection.myOrders,
                pageBuilder: (context, state) => MaterialPage<void>(
                      key: state.pageKey,
                      child: MyOrder(),
                    ),
                routes: [
                  GoRoute(
                      path: PageCollection.order,
                      pageBuilder:(context, state) {
                        OrderDataModel? serviceDetail = state.extra != null
                            ? state.extra as OrderDataModel
                            : null;
                        return MaterialPage<void>(
                          key: state.pageKey,
                          child: OrderDetails(
                              orderData: serviceDetail!,
                          ),
                        );
                      },
                  ),
                ]),
            GoRoute(
              path: PageCollection.myAccount,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: MyAccount(),
              ),
            ),
            GoRoute(
              path: PageCollection.privacyPolicy,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: PrivacyPolicy(),
              ),
            ),
            GoRoute(
              path: PageCollection.refundPolicy,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: RefundPolicy(),
              ),
            ),
            GoRoute(
              path: PageCollection.termsOfUse,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: TermsOfUse(),
              ),
            ),
          ]),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: Loading(),
    ),
  );
}
