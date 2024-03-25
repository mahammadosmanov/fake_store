part of 'switch_bloc.dart';

sealed class SwitchState extends Equatable {
  const SwitchState();

  @override
  List<Object> get props => [];
}

final class SwitchInitial extends SwitchState {
  const SwitchInitial();
}

final class SwitchedState extends SwitchState {
  const SwitchedState({
    required this.productCategoryList,
  });
  final List<ProductCategory> productCategoryList;
}
