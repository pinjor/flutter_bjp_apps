import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/api_constants.dart';
import '../../domain/discussion_model.dart';

class DiscussionDetailsScreen extends StatelessWidget {
  const DiscussionDetailsScreen({super.key, required this.discussion});

  final DiscussionModel discussion;

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
    return Scaffold(
      appBar: AppBar(title: Text('আলোচনা')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: imageUri,
                    height: 350,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  discussion.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  'By admin, Published: $formattedDate',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),

                Html(data: discussion.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
