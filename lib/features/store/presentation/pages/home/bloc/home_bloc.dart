import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/helper/locator.dart';
import 'package:test_task/features/store/domain/entities/product_entity.dart';
import 'package:test_task/features/store/domain/repositories/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository _productRepository = locator.get<ProductRepository>();
  HomeBloc() : super(const HomeInitial()) {
    on<InitialEvent>(
      (event, emit) async {
        await _productRepository.getProductsList().then(
              (value) => value.fold(
                (l) => emit(
                  ProductFailure(),
                ),
                (r) {
                  emit(
                    HomeSet(productList: r),
                  );
                },
              ),
            );
      },
    );

    on<FilterEvent>(
      (event, emit) async {
        _productRepository.filterProductList().fold(
          (l) => emit(
            ProductFailure(),
          ),
          (r) {
            emit(
              HomeSet(productList: r),
            );
          },
        );
      },
    );
  }
}
