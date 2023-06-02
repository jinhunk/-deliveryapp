import 'package:deliveryapp_project/common/const/colors.dart';
import 'package:deliveryapp_project/restaurant/model/rastaurant_model.dart';
import 'package:deliveryapp_project/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  // 이미지
  final Widget image;
  //레스토랑 이름
  final String name;
  //레스토랑 태그
  final List<String> tages;
  //평점 갯수
  final int ratingsCount;
  //배송걸리는 시간
  final int deliveryTime;
  //배송 비용
  final int deliveryFee;
  //평균 평점
  final double ratings;
  //상세 카드 여부
  final bool isDetail;
  //Hero 위젯 태그
  final String? heroKey;
  //상세 내용
  final String? detail;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.tages,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.isDetail = false,
    this.detail,
    this.heroKey,
  });

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      heroKey: model.id,
      name: model.name,
      tages: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
      isDetail: isDetail,
      detail: model is RestaurantDetailModel ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (heroKey != null)
          Hero(
            tag: ObjectKey(heroKey),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDetail ? 0 : 12.0),
              child: image,
            ),
          ),
        if (heroKey == null)
          ClipRRect(
            borderRadius: BorderRadius.circular(isDetail ? 0 : 12.0),
            child: image,
          ),
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                tages.join(' · '),
                style: const TextStyle(
                  color: BODY_TEXT_COLOR,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  IconText(
                    icon: Icons.star,
                    label: ratings.toString(),
                  ),
                  renderDot(),
                  IconText(
                    icon: Icons.receipt,
                    label: ratingsCount.toString(),
                  ),
                  renderDot(),
                  IconText(
                    icon: Icons.timelapse_outlined,
                    label: '$deliveryTime 분',
                  ),
                  renderDot(),
                  IconText(
                    icon: Icons.monetization_on,
                    label: deliveryFee == 0 ? '무료' : deliveryFee.toString(),
                  ),
                ],
              ),
              if (detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(detail!),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget renderDot() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      '·',
      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
    ),
  );
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconText({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
