part of 'maincubite_cubit.dart';

abstract class MaincubiteState extends Equatable {
  const MaincubiteState();

  @override
  List<Object> get props => [];
}

class MaincubiteInitial extends MaincubiteState {}

class MaincubiteNetworkError extends MaincubiteState {}

class MaincubiteLoading extends MaincubiteState {}

class MaincubiteError extends MaincubiteState {
  final String message;
  MaincubiteError(this.message);

  @override
  List<Object> get props => [message];
}

class MaincubitLoaded extends MaincubiteState {
  final SliderResModel slider;
  final CategoryModel category;
  final VendorsModelRes vendors;
  final ProductModelRes products;
  MaincubitLoaded(this.slider, this.category, this.vendors, this.products);

  @override
  List<Object> get props => [slider, category, vendors, products];
}

class MaincubitCategoryLoaded extends MaincubiteState {
  final SliderResModel slider;
  final CategoryModel category;
  MaincubitCategoryLoaded(this.slider, this.category);

  @override
  List<Object> get props => [slider, category];
}

class MaincubitVendorsLoaded extends MaincubiteState {
  final SliderResModel slider;
  final CategoryModel category;
  final VendorsModelRes vendors;
  MaincubitVendorsLoaded(this.slider, this.category, this.vendors);

  @override
  List<Object> get props => [slider, category, vendors];
}

class MaincubitProductLoaded extends MaincubiteState {
  final SliderResModel slider;
  final CategoryModel category;
  final VendorsModelRes vendors;
  final ProductModelRes products;
  MaincubitProductLoaded(
      this.slider, this.category, this.vendors, this.products);

  @override
  List<Object> get props => [slider, category, vendors, products];
}

class MaincubitSearchProduct extends MaincubiteState {
  final ProductModelRes products;
  MaincubitSearchProduct(this.products);

  @override
  List<Object> get props => [products];
}

class MaincubitVendorScreenLoaded extends MaincubiteState {
  final VendorsModelRes vendors;
  MaincubitVendorScreenLoaded(this.vendors);

  @override
  List<Object> get props => [vendors];
}

class VendorProductsLoaded extends MaincubiteState {
  final ProductModelRes products;
  VendorProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class MainCubiteProductAndSection extends MaincubiteState {
  final CategoryModel category;
  final ProductModelRes products;
  MainCubiteProductAndSection(this.category, this.products);

  @override
  List<Object> get props => [category, products];
}
