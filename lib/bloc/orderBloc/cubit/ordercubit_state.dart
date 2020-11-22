part of 'ordercubit_cubit.dart';

abstract class OrdercubitState extends Equatable {
  const OrdercubitState();

  @override
  List<Object> get props => [];
}

class OrdercubitInitial extends OrdercubitState {}

class OrdercubitLoading extends OrdercubitState {}

class OrdercubitNetworkError extends OrdercubitState {}

class OrdercubitError extends OrdercubitState {
  final String message;
  OrdercubitError(this.message);

  @override
  List<Object> get props => [message];
}

class OrdercubitLoaded extends OrdercubitState {
  final OrdersModelRes oredrs;
  OrdercubitLoaded(this.oredrs);
  @override
  List<Object> get props => [oredrs];
}

class OrdercubitDetailsLoaded extends OrdercubitState {
  final OrderDetailsModelRes order;
  final String role;
  OrdercubitDetailsLoaded(this.order, this.role);
  @override
  List<Object> get props => [order, role];
}
