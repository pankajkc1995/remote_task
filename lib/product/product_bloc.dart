import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remote_task/product/product_event.dart';
import 'package:remote_task/product/product_state.dart';
import '../services/ApiService.dart';



class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;

  ProductBloc(this.apiService) : super(ProductLoading()){
    on<ProductEvent>((event, emit) {});
    on<FetchProducts>(_fetchProductData);
    on<FetchCurrentLocation>(_fetchCurrentLocation);
  }

  _fetchCurrentLocation(FetchCurrentLocation event, emit)
  async {
    try{
      Position? currentPosition;
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled, return
        emit(ProductError("Location services are not enabled"));
      }

      // Check for location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, return
          emit(ProductError("Permissions are denied"));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied, return
        emit(ProductError("Permissions are permanently denied"));
      }

      // Get the current location
      currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("Get User Current Location "+currentPosition.latitude.toString()+" , "+currentPosition.longitude.toString());
      emit(FetchUserCurrentLocation(LatLng(currentPosition.latitude,currentPosition.longitude)));
    }catch(e){
      print("Failed to get Location $e");
      emit(ProductError(e.toString()));
    }
  }


  _fetchProductData(FetchProducts event, emit) async {
    try {
        emit(ProductLoading());
        final products = await apiService.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
      emit(ProductError("Failed to load products"));
      }
  }
}