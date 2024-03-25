part of 'switch_bloc.dart';

sealed class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object> get props => [];
}

class Filter extends SwitchEvent {
  const Filter({
    required this.productCategory,
  });
  final ProductCategory productCategory;

  @override
  List<Object> get props => [productCategory];
}
