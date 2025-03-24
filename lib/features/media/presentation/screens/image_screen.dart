import 'package:flutter/material.dart';

class AlbumScreen extends StatelessWidget {
  final List<Map<String, String>> albums = [
    {
      'imageUrl': 'assets/images/photo3.png',
      'title': 'অ্যালবাম ১',
      'date': '23 February, 2025',
    },
    // Add more albums here if needed
  ];

  AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToGallery(context),
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  // Album Cover Image
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      albums[index]['imageUrl']!,
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
                          albums[index]['title']!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          albums[index]['date']!,
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
          );
        },
      ),
    );
  }

  void _navigateToGallery(BuildContext context) {
    // Navigate to GalleryScreen with image asset paths
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryScreen(
          imageUrls: [
          'assets/images/pic.png',
            'assets/images/photo3.png',
            'assets/images/photo2.png',

          ],
        ),
      ),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  final List<String> imageUrls;

  const GalleryScreen({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('অ্যালবাম 1')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns in the grid
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8, // Aspect ratio of the grid items
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToFullScreen(context, index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageUrls[index], // Using Image.asset here for local assets
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToFullScreen(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageScreen(
          imageUrls: imageUrls,
          initialIndex: index,
        ),
      ),
    );
  }
}

class FullScreenImageScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FullScreenImageScreen({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
  });

  @override
  State<FullScreenImageScreen> createState() => _FullScreenImageScreenState();
}

class _FullScreenImageScreenState extends State<FullScreenImageScreen> {
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
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            panEnabled: true,
            minScale: 0.1,
            maxScale: 5.0,
            child: Hero(
              tag: 'image_$index',
              child: Image.asset(
                widget.imageUrls[index], // Using Image.asset for local assets
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: AlbumScreen()));
}
