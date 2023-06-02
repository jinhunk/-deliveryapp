import 'package:deliveryapp_project/common/const/data.dart';
import 'package:deliveryapp_project/common/model/model_with_id.dart';
import 'package:deliveryapp_project/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rastaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable() // 중복된 json매핑을 자동화하는 패키지
class RestaurantModel implements IModelWithId {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });
//json으로부터 인스턴스를 만들었을때
  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

//json으로 변경이될때
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  // factory RestaurantModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestaurantModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: 'http://$ip${json['thumbUrl']}',
  //     tags: List.from(json['tags']), //다이나믹에서 String으로 전환
  //     priceRange: RestaurantPriceRange.values.firstWhere(
  //       (e) => e.name == json['priceRange'],
  //     ),
  //     ratings: json['ratings'],
  //     ratingsCount: json['ratingsCount'],
  //     deliveryTime: json['deliveryTime'],
  //     deliveryFee: json['deliveryFee'],
  //   );
  // }
}
