import 'package:get/get.dart';
import '../models/project_model.dart';
import '../repositories/map_repository.dart';

class MapDataController extends GetxController {
  final MapRepository _repo = MapRepository();
  final RxList<ProjectModel> projects = <ProjectModel>[].obs;
  final isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  void loadProjects() async {
    try {
      isLoading(true);
      projects.value = await _repo.fetchProjects();
    } catch (e) {
      Get.snackbar("Error", "Failed to load projects");
    } finally {
      isLoading(false);
    }
  }
}
