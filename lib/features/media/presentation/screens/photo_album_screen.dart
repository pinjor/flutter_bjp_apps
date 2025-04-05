import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/photo_model.dart';
import '../controllers/media_controller.dart';
import 'gallery_screen.dart';

class PhotoAlbumScreen extends ConsumerStatefulWidget {
  const PhotoAlbumScreen({super.key});

  @override
  ConsumerState<PhotoAlbumScreen> createState() => _PhotoAlbumScreenState();
}

class _PhotoAlbumScreenState extends ConsumerState<PhotoAlbumScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mediaControllerProvider.notifier).fetchAllPhotos();
    });
  }

  void _goToGalleryScreen(
    BuildContext context,
    List<PhotoGallery>? photoGallery,
  ) {
    if (photoGallery == null || photoGallery.isEmpty) {
      showMessageToUser(context: context, message: 'কোন ছবি নেই');

      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryScreen(galleries: photoGallery),
      ),
    );
  }

  String _getFormattedDate(DateTime? date) {
    if (date == null) {
      return '';
    }

    return DateFormat('d MMMM, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final photoState = ref.watch(mediaControllerProvider);
    return Scaffold(
      body: photoState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text(err.toString())),
        data: (photoData) {
          // Cast the dynamic data as a PhotoModel.

          if (photoData is! PhotoModel) {
            return const Center(child: CircularProgressIndicator());
          }

          final photoAlbumPreviewImageUrl =
              Uri(
                scheme: 'http',
                host: ApiConstants.baseUrl,
                port: ApiConstants.port,
                path: 'storage/${photoData.image}',
              ).toString();

          return ListView(
            padding: const EdgeInsets.all(8),
            children: [
              GestureDetector(
                onTap: () {
                  _goToGalleryScreen(context, photoData.galleries);
                },
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child:
                            photoData.image != null
                                ? CachedNetworkImage(
                                  imageUrl: photoAlbumPreviewImageUrl,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                                : Image.asset(
                                  'assets/images/photo3.png',
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                      ),
                      // Album Title and Date
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                photoData.title ?? 'অ্যালবাম',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _getFormattedDate(photoData.createdAt),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
