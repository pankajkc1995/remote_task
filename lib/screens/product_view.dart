import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remote_task/AppController.dart';
import 'package:remote_task/AppUtils/routers/route_name.dart';
import 'package:remote_task/models/Product.dart';
import 'package:remote_task/product/product_event.dart';
import '../AppUtils/Utils.dart';
import 'DirectionsScreen.dart';
import '../product/product_bloc.dart';
import '../product/product_state.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  LatLng? getCurrentLatlng;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Product Show')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FetchUserCurrentLocation) {
            getCurrentLatlng = state.currLatlng;
            context.read<ProductBloc>().add(FetchProducts());
            print("getLocation State " + getCurrentLatlng!.latitude.toString());
          } else if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(FetchCurrentLocation());
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is ProductLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                if (await checkInternetConnection()) {
                  context.read<ProductBloc>().add(FetchCurrentLocation());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No internet connection')),
                  );
                }
              },
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black26,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Image.network(
                          fit: BoxFit.cover,
                          width: mediaQuery.size.width * 0.2,
                          height: mediaQuery.size.height * 0.2,
                          product.imageUrl!, errorBuilder:
                              (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                        // Return a placeholder image or an error widget
                        return Container(
                          width: mediaQuery.size.width * 0.2,
                          height: mediaQuery.size.height * 0.2,
                          child: Expanded(
                              child: Icon(
                            Icons.error,
                            color: Colors.red,
                          )),
                        ); // Ensure you have a placeholder image in your assets
                      }),
                      title: Text(product.title!),
                      subtitle: Text(product.body!),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Distanse: \n' +
                              AppController.calculateDistance(
                                  getCurrentLatlng!.latitude,
                                  getCurrentLatlng!.longitude,
                                  product.coordinates![0].toDouble(),
                                  product.coordinates![1].toDouble())),
                          InkWell(
                            onTap: () async {
                              if (await checkInternetConnection()) {

                               // List<Product> productlist=state.products;
                               // context.go(AppRouteNames.directionRouteName+"?userLocation=$getCurrentLatlng&UserIndex=$index&products=$productlist");

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DirectionsScreen(
                                      userLocation: getCurrentLatlng!,
                                      UserIndex: index,
                                      products: state.products,
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('No internet connection')),
                                );
                              }
                            },
                            child:Container(
                              color: Colors.blue,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 3, right: 3, top: 3, bottom: 3),
                                child: const Text(
                                  'View Direction',
                                  style: TextStyle(color: Colors.amberAccent),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
