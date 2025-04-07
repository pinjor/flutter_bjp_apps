import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/api_constants.dart';
import '../../domain/photo_model.dart';

class ViewImageScreen extends StatefulWidget {
  final List<PhotoGallery> galleries;
  final int initialIndex;

  const ViewImageScreen({
    super.key,
    required this.galleries,
    required this.initialIndex,
  });

  @override
  State<ViewImageScreen> createState() => _FullScreenImageScreenState();
}

class _FullScreenImageScreenState extends State<ViewImageScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.galleries.length,
        itemBuilder: (context, index) {
          final gallery = widget.galleries[index];
          final imagePathUrl =
              Uri(
                scheme: 'http',
                host: ApiConstants.baseUrl,
                port: ApiConstants.port,
                path: 'storage/${gallery.path}',
              ).toString();
          return InteractiveViewer(
            panEnabled: true,
            minScale: 0.1,
            maxScale: 5.0,
            child: Hero(
              tag: 'photo_$index',
              child:
                  gallery.path != null
                      ? CachedNetworkImage(
                        imageUrl: imagePathUrl,
                        fit: BoxFit.contain,
                      )
                      : Image.asset(
                        'assets/images/photo3.png',
                        fit: BoxFit.contain,
                      ),
            ),
          );
        },
      ),
    );
  }
}
