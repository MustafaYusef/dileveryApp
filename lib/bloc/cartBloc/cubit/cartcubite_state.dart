part of 'cartcubite_cubit.dart';

abstract class CartcubiteState extends Equatable {
  const CartcubiteState();

  @override
  List<Object> get props => [];
}

class CartcubiteInitial extends CartcubiteState {}

class OrderLoading extends CartcubiteState {}

class CartLoaded extends CartcubiteState {
  final List<ItemLocal> items;
  bool orderLoading;
  CartLoaded(this.items, this.orderLoading);

  @override
  List<Object> get props => [items];
}
