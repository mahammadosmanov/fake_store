part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeSet extends HomeState {
  const HomeSet({
    required this.productList,
  });

  final List<ProductEntity> productList;

  @override
  List<Object> get props => [productList];
}

final class ProductFailure extends HomeState {}

// final class ElectronicsOn extends HomeState {
//   const ElectronicsOn({
//     required this.isElectronicsOn,
//     this.productList,
//   });
//   final bool isElectronicsOn;
//   final List<dynamic>? productList;
// }

// final class ManClothOn extends HomeState {
//   const ManClothOn({required this.isManClothOn, this.productList});
//   final bool isManClothOn;
//   final List<dynamic>? productList;
// }

// final class JeweleryOn extends HomeState {
//   const JeweleryOn({required this.isJeweleryOn, this.productList});
//   final bool isJeweleryOn;
//   final List<dynamic>? productList;
// }

// final class WomanClothOn extends HomeState {
//   const WomanClothOn({required this.isWomanClothOn, this.productList});
//   final bool isWomanClothOn;
//   final List<dynamic>? productList;
// }
