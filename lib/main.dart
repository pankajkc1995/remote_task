import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_task/AppUtils/app_color.dart';
import 'package:remote_task/screens/product_view.dart';
import 'services/ApiService.dart';
import 'product/product_bloc.dart';
import 'product/product_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Listing App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: AppColors.white,
        useMaterial3: true,
        fontFamily: 'Inter',
        dividerTheme: DividerThemeData(
          color: AppColors.greyECECEC,
          thickness: 1,
        ),
      ),
      home: BlocProvider(
        create: (context) => ProductBloc(ApiService())..add(FetchCurrentLocation()),
        child: ProductView(),
      ),
    );
  }
}
