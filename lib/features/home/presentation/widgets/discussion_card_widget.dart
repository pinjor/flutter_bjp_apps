import 'package:bjp_app/core/constants/api_constants.dart';
import 'package:bjp_app/features/our_discussion/domain/discussion_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../config/app_colors.dart';
import '../../../our_discussion/presentation/screens/discussion_details_screen.dart';

class DiscussionCardWidget extends StatelessWidget {
  const DiscussionCardWidget({super.key, required this.discussion});

  final DiscussionModel discussion;

  void _showDiscussionDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DiscussionDetailsScreen(discussion: discussion),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUri =
        Uri(
          scheme: 'http',
          host: ApiConstants.baseUrl,
          port: ApiConstants.port,
          path: '/storage/${discussion.image}',
        ).toString();

    final formattedDate = DateFormat(
      'dd MMM yyyy',
    ).format(DateTime.parse(discussion.updatedAt));

    return GestureDetector(
      onTap: () => _showDiscussionDetails(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              CachedNetworkImage(
                height: 350,
                width: 280,

                imageUrl: imageUri,
                fit: BoxFit.cover,
              ),

              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: EdgeInsets.all(4),
                  constraints: BoxConstraints(maxWidth: 180, maxHeight: 20),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'আলোচনা',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor.withOpacity(0.4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        discussion.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'admin',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
