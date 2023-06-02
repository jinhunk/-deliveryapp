import 'package:deliveryapp_project/common/const/data.dart';
import 'package:deliveryapp_project/common/utils/data_utils.dart';
import 'package:deliveryapp_project/restaurant/model/rastaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable() // json매핑을 자동화시켜주는 패키지
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaruantProductModel> products;

  RestaurantDetailModel({
    required super.id, //부모클래스 받아올떄 this 대신 super
    required super.name,
    @JsonKey(
      fromJson: DataUtils.pathToUrl,
    )
        required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  //json으로부터 인스턴스를 만들었을때
  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailModelFromJson(json);

  static pathToUrl(String value) {
    return 'http://$ip$value';
  }
}

@JsonSerializable()
class RestaruantProductModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  final String detail;
  final int price;

  RestaruantProductModel(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.detail,
      required this.price});

  factory RestaruantProductModel.fromJson(Map<String, dynamic> json) =>
      _$RestaruantProductModelFromJson(json);

  // factory RestaruantProductModel.fromJson(
  //     {required Map<String, dynamic> json}) {
  //   return RestaruantProductModel(
  //     id: json['id'],
  //     name: json['name'],
  //     imgUrl: 'http://$ip${json['imgUrl']}',
  //     detail: json['detail'],
  //     price: json['price'],
  //   );
  // }
}
