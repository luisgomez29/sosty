import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sosty/config/provider/project_provider.dart';
import 'package:sosty/domain/models/project/project_item.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';
import 'package:sosty/ui/components/projects/project_card.dart';
import 'package:sosty/ui/screens/projects/projects_detail_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with AutomaticKeepAliveClientMixin {
  Future<List<ProjectItem>>? futureProjects;
  Future<ProjectItem>? futureProjectOpen;

  void _fetchProjectsList() {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);

    final projects = projectProvider.projectUseCase.getAll();
    setState(() {
      futureProjects = projects;
    });
  }

  void _fetchProjectOpen() {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    final project =
        projectProvider.projectUseCase.getProjectPublicByCode("1110");
    setState(() {
      futureProjectOpen = project;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProjectsList();
    _fetchProjectOpen();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _fetchProjectsList();
          _fetchProjectOpen();
        },
        child: CustomScrollView(
          slivers: <Widget>[
            const Navbar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const NavbarClipper(),
                  ContentSection(
                    offsetY: -80.0,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            // TODO: Eliminar ya que solo se usa para simular la participación
                            FutureBuilder<ProjectItem>(
                              future: futureProjectOpen,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    ProjectItem project = snapshot.data!;
                                    return ProjectsCard(
                                      project: project,
                                      navigator: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProjectDetailScreen(
                                              projectCode: project.projectCode,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    if (kDebugMode) {
                                      print(
                                          "PROJECT_OPEN_ERROR => ${snapshot.error}");
                                    }
                                  }
                                }
                                return const SizedBox();
                              },
                            ),
                            FutureBuilder<List<ProjectItem>>(
                              future: futureProjects,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (context, index) {
                                        ProjectItem project =
                                            snapshot.data![index];
                                        return Column(
                                          children: [
                                            ProjectsCard(
                                              project: project,
                                              navigator: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProjectDetailScreen(
                                                      projectCode:
                                                          project.projectCode,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    if (kDebugMode) {
                                      print(
                                          "PROJECTS_ERROR => ${snapshot.error}");
                                    }
                                    return const LoadDataError();
                                  }
                                }
                                return const LoadingIndicator();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
