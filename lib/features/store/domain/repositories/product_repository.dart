import 'package:dartz/dartz.dart';
import 'package:test_task/core/error/failure/failure.dart';
import 'package:test_task/features/store/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProductsList();

  Either<Failure, List<ProductEntity>> filterProductList();

  List<ProductCategory> setFilters(ProductCategory productCategory);
}
