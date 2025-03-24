import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoAlbumScreen extends StatelessWidget {
  final List<Map<String, String>> videoAlbums = [
    {
      'imageUrl': 'assets/images/picture_of_mans.png', // Video album cover image
      'title': 'ভিডিও অ্যালবাম ১',
      'date': '23 February, 2025',
    },
    // Add more video albums here if needed
  ];

  VideoAlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Video Albums')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: videoAlbums.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToVideoGallery(context),
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  // Video Album Cover Image
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.asset(
                      videoAlbums[index]['imageUrl']!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Video Album Title and Date
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          videoAlbums[index]['title']!,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          videoAlbums[index]['date']!,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToVideoGallery(BuildContext context) {
    // Here, we can pass the video details if needed to VideoGalleryScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoGalleryScreen(
          videoUrls: [
            'https://www.w3schools.com/html/movie.mp4',

          ],
        ),
      ),
    );
  }
}

class VideoGalleryScreen extends StatelessWidget {
  final List<String> videoUrls;

  const VideoGalleryScreen({super.key, required this.videoUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ভিডিও')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns in the grid
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8, // Aspect ratio of the grid items
        ),
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToFullScreenVideo(context, index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset( // Display thumbnail image for the video
                'assets/images/picture_of_mans.png', // Replace with a real thumbnail
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToFullScreenVideo(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoScreen(
          videoUrls: videoUrls,
          initialIndex: index,
        ),
      ),
    );
  }
}

class FullScreenVideoScreen extends StatefulWidget {
  final List<String> videoUrls;
  final int initialIndex;

  const FullScreenVideoScreen({
    super.key,
    required this.videoUrls,
    required this.initialIndex,
  });

  @override
  State<FullScreenVideoScreen> createState() => _FullScreenVideoScreenState();
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrls[widget.initialIndex])
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VideoAlbumScreen(),
  ));
}
