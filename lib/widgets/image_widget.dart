// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:freeorder_flutter/main.dart';

class ImageWidget extends StatefulWidget {
  final String id;
  final double width;
  final double height;

  const ImageWidget({
    super.key,
    required this.id,
    required this.width,
    required this.height,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  BoxFit _boxFit = BoxFit.cover; // 기본적으로 cover로 설정

  @override
  void initState() {
    super.initState();
    _loadImageSize();
  }

  void _loadImageSize() {
    String imageUrl = getImageUrl(widget.id);
    Image image = Image.network(imageUrl);

    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool synchronousCall) {
        double imageWidth = info.image.width.toDouble();
        double imageHeight = info.image.height.toDouble();

        setState(() {
          // 가로가 더 길면 `cover`, 세로가 더 길면 `contain`
          _boxFit = (imageWidth > imageHeight) ? BoxFit.cover : BoxFit.contain;
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = getImageUrl(widget.id);
    debugPrint("이미지 출력 - 상품 아이디: ${widget.id}, URL: $imageUrl");

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: widget.width,
      height: widget.height,
      fit: _boxFit,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) {
        debugPrint("❌ 이미지 로드 실패: $url, 오류: $error");
        return const Center(child: Icon(Icons.error, size: 50, color: Colors.red));
      },
    );
  }

  String getImageUrl(String id, {bool isThumb = false}) {
    final GlobalConfig config = GlobalConfig();
    final String url = config.backendUrl;
    final String productURL = "$url/pimg?id=";
    final String noticeURL = "$url/timg?id=";
    return isThumb ? noticeURL + id : productURL + id;
  }
}
