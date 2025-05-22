import 'package:get/get.dart';
import '../repositories/project_repository.dart';
import '../models/project_model.dart';

class ProjectController extends GetxController {
  static ProjectController get instance => Get.find();

  final ProjectRepository _repo = ProjectRepository();

  var isLoading = false.obs;
  final allProjects = <ProjectModel>[].obs;
  final searchText = ''.obs;
  final filteredProjects = <ProjectModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProjects();
    allProjects;
    print("allProjects>>>>>  $allProjects");

  }

  void loadProjects() async {
    try {
      isLoading(true);
      allProjects.value = await _repo.fetchProjects();
    } catch (e) {
      Get.snackbar("Error", "Failed to load projects");
    } finally {
      isLoading(false);
    }
  }

  void searchProjects(String query) {
    filteredProjects.value =
        allProjects.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  Future<void> addProject(ProjectModel project) async {
    await _repo.addProject(project);
    loadProjects();
  }

  Future<void> deleteProject(String id) async {
    await _repo.deleteProject(id);
    loadProjects();
  }

  Future<void> updateProject(ProjectModel project) async {
    await _repo.updateProject(project);
    loadProjects();
  }


}
