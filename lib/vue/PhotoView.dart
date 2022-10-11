import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Photoview extends StatefulWidget {
  Photoview({required this.position, required this.listimage});

  final listimage;
  final int position;

  @override
  State<Photoview> createState() => _PhotoviewState();
}

class _PhotoviewState extends State<Photoview> {
  var pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: widget.position);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        var img = widget.listimage[index].path;
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(img),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 1.2,
          heroAttributes: PhotoViewHeroAttributes(tag: img),
        );
      },
      itemCount: widget.listimage.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded /
                    event.expectedTotalBytes!.toInt(),
          ),
        ),
      ),
      backgroundDecoration: BoxDecoration(color: Colors.black),
      pageController: pageController,
    ));
  }

  void onPageChanged(int index) {
    setState(() {
      // currentIndex = index;
    });
  }
}
