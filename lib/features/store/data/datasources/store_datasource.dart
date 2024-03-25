import 'package:dio/dio.dart';
import 'package:test_task/core/error/exception/exception.dart';
import 'package:test_task/features/store/data/models/product_model.dart';

abstract class StoreDataSource {
  Future<String> login(
    String userName,
    String password,
  );

  Future<List<ProductModel>> getProductsList();
}

class StoreDataSourceImpl extends StoreDataSource {
  final Dio _dio = Dio();

  @override
  Future<String> login(
    String userName,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        'https://fakestoreapi.com/auth/login',
        data: {
          "username": userName,
          "password": password,
        },
      );
      return response.data['token'];
    } catch (e) {
      throw DataSourceException();
    }
  }

  @override
  Future<List<ProductModel>> getProductsList() async {
    try {
      final response = await _dio.get(
        'https://fakestoreapi.com/products',
      );
      List<dynamic> data = response.data;

      return data.map(
        (e) {
          return ProductModel.fromJson(e);
        },
      ).toList();
    } catch (e) {
      throw DataSourceException();
    }
  }
}
