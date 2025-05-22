import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../controllers/media_controller.dart';

class MediaView extends StatelessWidget {
  MediaView({super.key});

  final MediaController controller = Get.put(MediaController());

  @override
  Widget build(BuildContext context) {
    controller.fetchMedia();

    return Scaffold(
      appBar: AppBar(title: const Text("Media")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
        label: Row(
          children: [
            IconButton(onPressed: controller.pickAndUploadImage, icon: const Icon(Icons.image)),
            IconButton(onPressed: controller.pickAndUploadVideo, icon: const Icon(Icons.video_camera_front)),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.mediaList.isEmpty) {
          return const Center(child: Text("No media uploaded yet"));
        }

        return
          ListView.builder(
            itemCount: controller.mediaList.length,
            itemBuilder: (context, index) {
              final media = controller.mediaList[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: media.type == "image" ? Image.network(media.url) : VideoPlayerWidget(url: media.url),
              );
            },
          );
      }),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({super.key, required this.url});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller))
        : const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
