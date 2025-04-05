import 'package:bjp_app/features/media/presentation/screens/view_image_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/photo_model.dart';

class GalleryScreen extends StatelessWidget {
  final List<PhotoGallery> galleries;

  const GalleryScreen({super.key, required this.galleries});

  void _goToViewImageScreen(BuildContext context, int index) {
    if (galleries.isEmpty) {
      showMessageToUser(context: context, message: 'কোন ছবি নেই');

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                ViewImageScreen(galleries: galleries, initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('অ্যালবাম')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // 2 columns
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.9, // Adjust the aspect ratio as needed
        ),
        itemCount: galleries.length,
        itemBuilder: (context, index) {
          final gallery = galleries[index];
          // http://116.68.206.157:9445/storage/photos/1J6mYXPO6Gyy2bl5n99j42iIjQYeWn02BBWfViUn.jpg

          final imagePathUrl =
              Uri(
                scheme: 'http',
                host: ApiConstants.baseUrl,
                port: ApiConstants.port,
                path: 'storage/${gallery.path}',
              ).toString();

          return GestureDetector(
            onTap: () => _goToViewImageScreen(context, index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:
                  gallery.path != null
                      ? CachedNetworkImage(
                        imageUrl: imagePathUrl,
                        fit: BoxFit.cover,
                      )
                      : Image.asset(
                        'assets/images/photo3.png',
                        fit: BoxFit.cover,
                      ),
            ),
          );
        },
      ),
    );
  }
}
