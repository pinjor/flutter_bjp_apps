import 'package:bjp_app/core/ui/custom_loader.dart';
import 'package:bjp_app/features/media/presentation/screens/video_gallery_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/video_model.dart';
import '../controllers/media_controller.dart';

class VideoAlbumScreen extends ConsumerStatefulWidget {
  const VideoAlbumScreen({super.key});

  @override
  ConsumerState<VideoAlbumScreen> createState() => _VideoAlbumScreenState();
}

class _VideoAlbumScreenState extends ConsumerState<VideoAlbumScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mediaControllerProvider.notifier).fetchAllVideos();
    });
  }

  void _navigateToVideoGallery(
    BuildContext context,
    List<VideoGalleryModel>? galleries,
  ) {
    if (galleries == null || galleries.isEmpty) {
      showMessageToUser(context: context, message: 'কোন ভিডিও নেই');
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoGalleryScreen(galleries: galleries),
      ),
    );
  }

  String _getFormattedDate(String? date) {
    if (date == null) {
      return '';
    }

    return DateFormat('d MMMM, yyyy').format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(mediaControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('ভিডিও অ্যালবাম')),
      body: videoState.when(
        loading: () => CustomLoader(),
        error: (err, st) => Center(child: Text(err.toString())),
        data: (videoData) {
          // Cast the dynamic data as a VideoModel.

          if (videoData is! VideoModel) {
            return const Center(child: CircularProgressIndicator());
          }


          if (videoData.galleries == null || videoData.galleries!.isEmpty) {
            return const Center(child: Text('কোন ভিডিও অ্যালবাম নেই'));
          }

          final albumPreviewImageUrl =
              Uri(
                scheme: 'http',
                host: ApiConstants.baseUrl,
                port: ApiConstants.port,
                path: 'storage/${videoData.image}',
              ).toString();
          return ListView(
            padding: const EdgeInsets.all(8),
            children: [
              GestureDetector(
                onTap:
                    () =>
                        _navigateToVideoGallery(context, videoData.galleries),
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
                      // Album Cover Image (using network image if available)
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child:
                            videoData.image != null
                                ? CachedNetworkImage(
                                  imageUrl: albumPreviewImageUrl,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                                : Image.asset(
                                  'assets/images/picture_of_mans.png',
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
                            Text(
                              videoData.createdAt != null
                                  ? _getFormattedDate(videoData.createdAt)
                                  : '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 8),
                            Text(
                              videoData.title ?? 'ভিডিও অ্যালবাম',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
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
