import 'package:test_task/features/store/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required this.id,
    super.title,
    super.price,
    super.description,
    super.category,
    super.image,
    super.rating,
  });
  int? id;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
        json['rating'] != null ? RatingModel?.fromJson(json['rating']) : null;
  }
}

class RatingModel extends RatingEntity {
  RatingModel({super.rate, super.count});

  RatingModel.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }
}
