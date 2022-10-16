import 'package:flutter/material.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';
import 'package:sosty/ui/components/projects/projects_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

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
                      children: const [
                        SizedBox(
                          height: 20,
                        ),
                        ProjectsCard(
                          imageUrl:
                              "https://sosty.blob.core.windows.net/sosty-public-files/20220811160531.jpeg",
                          title: "Novillas Morichales 2 (5014)",
                          estimatedProfitability: "14.07",
                          neoGanaderosCount: "28",
                          minimumInvestment: "7.000.000,000",
                          hoursLeft: "0",
                          animals: "61.54 Animales (14,153.75 Kg)",
                          animalsProgress: "50 Animales (11,500.00 Kg)",
                          raisedPercentage: "123.08",
                          progressIndicator: 1.0,
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
