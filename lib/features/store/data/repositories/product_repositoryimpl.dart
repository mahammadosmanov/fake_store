import 'package:dartz/dartz.dart';
import 'package:test_task/core/error/failure/failure.dart';
import 'package:test_task/core/helper/locator.dart';
import 'package:test_task/features/store/data/datasources/store_datasource.dart';
import 'package:test_task/features/store/data/models/product_model.dart';
import 'package:test_task/features/store/domain/entities/product_entity.dart';
import 'package:test_task/features/store/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  StoreDataSource storeDataSource = locator.get<StoreDataSource>();
  List<ProductModel> productList = [];
  List<ProductCategory> productFilterList =
      List.from(ProductCategory.values, growable: true);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsList() async {
    if (productList.isEmpty) {
      try {
        productList = await storeDataSource.getProductsList();
        return right(productList);
      } catch (e) {
        return left(ProductFailure());
      }
    } else {
      return right(productList);
    }
  }

  @override
  Either<Failure, List<ProductEntity>> filterProductList() {
    return right(
      productList
          .where(
            (element) => productFilterList.contains(element.productCategory),
          )
          .toList(),
    );
  }

  @override
  List<ProductCategory> setFilters(ProductCategory productCategory) {
    productFilterList.contains(productCategory)
        ? productFilterList.remove(productCategory)
        : productFilterList.add(productCategory);
    return productFilterList;
  }
}
