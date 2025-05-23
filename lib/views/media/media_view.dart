import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
       // backgroundColor: Colors.indigo,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 10,
        spaceBetweenChildren: 10,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.image, color: Colors.white),
            backgroundColor: Colors.deepPurple,
            label: 'Upload Image',
            onTap: controller.pickAndUploadImage,
          ),
          SpeedDialChild(
            child: const Icon(Icons.video_call, color: Colors.white),
            backgroundColor: Colors.pink,
            label: 'Upload Video',
            onTap: controller.pickAndUploadVideo,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.mediaList.isEmpty) {
          return const Center(
            child: Text("No media uploaded yet", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          );
        }

        return ListView.builder(
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
