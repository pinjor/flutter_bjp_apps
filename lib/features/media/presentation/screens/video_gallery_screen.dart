import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/video_model.dart';

class VideoGalleryScreen extends StatelessWidget {
  final List<VideoGalleryModel> galleries;

  const VideoGalleryScreen({super.key, required this.galleries});
  String _getFormattedDate(String? date) {
    if (date == null) {
      return '';
    }

    return DateFormat('d MMMM, yyyy').format(DateTime.parse(date));
  }

  void _navigateToFullScreenVideo(BuildContext context, int index) async {
    // final videoUrl = galleries[index].path;

    // if (videoUrl == null || videoUrl.isEmpty) {
    //   showMessageToUser(context: context, message: 'ভিডিও লিংক পাওয়া যায়নি');
    //   return;
    // }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => VideoPlayerScreen(videoUrl: videoUrl),
    //   ),
    // );

    // using url_launcher to open the video URL in the default browser

    final videoUrl = galleries[index].path;
    if (videoUrl == null || videoUrl.isEmpty) {
      showMessageToUser(context: context, message: 'ভিডিও লিংক পাওয়া যায়নি');
      return;
    }

    final Uri url = Uri.parse(videoUrl);

    if (url.scheme == 'http' || url.scheme == 'https') {
      // Open the URL in the default browser
      if (await canLaunchUrl(url)) {
        //
        await launchUrl(url);
      } else {
        showMessageToUser(
          context: context,
          message: 'Could not launch video URL',
        );
      }
    } else {
      showMessageToUser(context: context, message: 'Invalid video URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ভিডিও')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // 2 columns
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.3,
        ),
        itemCount: galleries.length,
        itemBuilder: (context, index) {
          final gallery = galleries[index];

          final galleryPreviewImageUrl =
              Uri(
                scheme: 'http',
                host: ApiConstants.baseUrl,
                port: ApiConstants.port,
                path: 'storage/${gallery.previewImage}',
              ).toString();
          return GestureDetector(
            onTap: () => _navigateToFullScreenVideo(context, index),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child:
                        gallery.previewImage != null
                            ? CachedNetworkImage(
                              imageUrl: galleryPreviewImageUrl,
                              fit: BoxFit.cover,
                            )
                            : Image.asset(
                              'assets/images/picture_of_mans.png',
                              fit: BoxFit.cover,
                            ),
                  ),
                ),

                // title
                const SizedBox(height: 8.0),
                Text(
                  _getFormattedDate(gallery.createdAt),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                // date
                const SizedBox(height: 4.0),
                Text(
                  gallery.comment ?? '',
                  style: const TextStyle(fontSize: 14.0, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
