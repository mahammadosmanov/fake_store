enum ProductCategory {
  electronics,
  menClothing,
  womenClothing,
  jewelery,
}

class ProductEntity {
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  RatingEntity? rating;

  ProductEntity(
      {this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  ProductCategory? get productCategory {
    switch (category) {
      case "electronics":
        return ProductCategory.electronics;
      case "men's clothing":
        return ProductCategory.menClothing;
      case "women's clothing":
        return ProductCategory.womenClothing;
      case "jewelery":
        return ProductCategory.jewelery;
      default:
        return null;
    }
  }
}

class RatingEntity {
  num? rate;
  int? count;

  RatingEntity({
    this.rate,
    this.count,
  });
}
