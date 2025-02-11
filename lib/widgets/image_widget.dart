import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String productURL = "http://10.0.2.2:8080/pimg?id=";
  final String noticeURL = "http://10.0.2.2:8080/timg?id=";
  final String id;

  const ImageWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("이미지 출력 - 상품 아이디 : $id");
    return CachedNetworkImage(
      imageUrl: getImgaeUrl(id),
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  String getImgaeUrl(String id, {bool isThumb = false}) {
    return isThumb ? noticeURL + id : productURL + id;
  }
}
