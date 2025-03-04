import 'package:cubic_api_controller/fetchApi/fetchApi_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FetchCubit extends Cubit<List<Product>?> {
  FetchCubit() : super(null); // Initial state is null (loading state)

  Future<void> fetchApi() async {
    try {
      emit(null); // Show loading state (null means loading)
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<Product> products =
            jsonData.map((json) => Product.fromJson(json)).toList();
        emit(products); // Emit the fetched list of products
      } else {
        emit([]); // Emit empty list on error
      }
    } catch (e) {
      emit([]); // Emit empty list on error
    }
  }
}
