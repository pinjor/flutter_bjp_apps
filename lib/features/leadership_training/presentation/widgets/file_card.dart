import 'package:bjp_app/core/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bjp_app/config/app_colors.dart';
import 'package:bjp_app/features/leadership_training/domain/course_model.dart';

class FileCard extends StatelessWidget {
  final CourseFiles file;

  const FileCard({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final fileDownloadUrl =
        Uri(
          scheme: 'http',
          host: ApiConstants.baseUrl,
          port: ApiConstants.port,
          path: '/storage/${file.filePath}',
        ).toString();
    // Extract file extension for type display
    final fileType = file.fileName.split('.').last.toUpperCase();

    Future<void> downloadFile(String url, BuildContext context) async {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Handle error (e.g., show a snackbar)
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              content: Text('ফাইল ডাউনলোড করা যাই নি'),
            ),
          );
      }
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => downloadFile(fileDownloadUrl, context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // File Type Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.themeColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  fileType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // File Title
              Text(
                file.fileName,
                style: const TextStyle(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
