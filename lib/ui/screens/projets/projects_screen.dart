import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sosty/config/provider/project_provider.dart';
import 'package:sosty/domain/models/project/project_item.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';
import 'package:sosty/ui/components/projects/projects_card.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';
import 'package:sosty/ui/screens/projets/projects_detail_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  Future<List<ProjectItem>>? futureProjects;

  void _fetchProjectsList() {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);

    final projects = projectProvider.projectUseCase.getAll();
    setState(() {
      futureProjects = projects;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProjectsList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const Navbar(),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const NavbarClipper(),
              ContentSection(
                offsetY: -60.0,
                child: Column(
                  children: [
                    const SectionTitle(
                      title: "Proyectos",
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder<List<ProjectItem>>(
                          future: futureProjects,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    ProjectItem project = snapshot.data![index];
                                    return Column(
                                      children: [
                                        ProjectsCard(
                                          imageUrl: project.projectImageUrl1,
                                          title:
                                              "${project.projectName} (${project.projectCode})",
                                          estimatedProfitability:
                                              project.projectProfitability,
                                          neoGanaderosCount:
                                              project.amountOfInvestors,
                                          hoursLeft: project.daysLeft,
                                          animals:
                                              "${project.amountOfCattles}  Animales (${FormatterHelper.doubleFormat(project.investmentCollected)} Kg)",
                                          animalsProgress:
                                              "Meta: ${project.amountOfCattles} Animales (${project.investmentRequired} Kg)",
                                          raisedPercentage: "123.08",
                                          progressIndicator: 1.0,
                                          navigator: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProjectDetailScreen(
                                                  project: project,
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
                                  print("PROJECTS_ERROR => ${snapshot.error}");
                                }
                                return const LoadDataError();
                              }
                            }
                            return LoadingIndicator(
                              color: Theme.of(context).primaryColor,
                            );
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
    );
  }
}
