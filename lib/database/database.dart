import 'package:hive/hive.dart';

part 'database.g.dart';

@HiveType(typeId: 1)
class ItemLocal {
  @HiveField(0)
  int itemId;
  @HiveField(1)
  String name;
  @HiveField(2)
  int quantity;
  @HiveField(3)
  String image;
  @HiveField(4)
  String price;

  ItemLocal(this.itemId, this.name, this.quantity, this.image, this.price);
}
// @UseDao(tables: [CartItems])
// class CartItemsDao extends DatabaseAccessor<AppDatabase>
//     with _$CartItemsDaoMixin {
//   final AppDatabase db;
//   CartItemsDao(this.db) : super(db);

//   Future<List<CartItem>> getAllItems() => select(cartItems).get();

// // select(animals)..where((a) => a.isMammal | a.amountOfLegs.equals(2));
//   Future insertItem(CartItem a) => into(cartItems).insert(a);
//   Future updateItem(CartItem a) => update(cartItems).replace(a);
//   Future deletItem(CartItem a) => delete(cartItems).delete(a);
//   Future deletAllItem() => delete(cartItems).go();
// }

// @UseDao(tables: [Favourites])
// class FavouritesDao extends DatabaseAccessor<AppDatabase>
//     with _$FavouritesDaoMixin {
//   final AppDatabase db;
//   FavouritesDao(this.db) : super(db);

//   Future<List<Favourite>> getAllFav() => select(favourites).get();

// // select(animals)..where((a) => a.isMammal | a.amountOfLegs.equals(2));
//   Future insertFav(Favourite a) => into(favourites).insert(a);
//   Future updateFav(Favourite a) => update(favourites).replace(a);
//   Future deletFav(Favourite a) => delete(favourites).delete(a);
//   Future deletAllFav() => delete(favourites).go();
// }
