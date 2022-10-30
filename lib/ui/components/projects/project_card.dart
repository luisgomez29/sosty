import 'package:flutter/material.dart';
import 'package:sosty/domain/models/project/project_item.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/custom_ink_well_card.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/network_image/custom_network_image.dart';
import 'package:sosty/ui/components/projects/project_current_widget.dart';
import 'package:sosty/ui/components/projects/project_goal_widget.dart';
import 'package:sosty/ui/components/projects/project_progress_indicator.dart';

class ProjectsCard extends StatelessWidget {
  const ProjectsCard({
    Key? key,
    required this.project,
    required this.navigator,
  }) : super(key: key);

  final ProjectItem project;
  final VoidCallback navigator;

  @override
  Widget build(BuildContext context) {
    // bool showMessage = false;
    return CustomInkWellCard(
      navigator: navigator,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: CustomNetworkImage(
              imageUrl: project.projectImageUrl1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              bottom: 15.0,
              left: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "${project.projectName} (${project.projectCode})",
                  style: Styles.bodyText1Bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                IconCard(
                  title: "${project.projectProfitability} % (E.A)",
                  subtitle: "Rentabilidad Estimada*",
                  elevation: 0,
                  padding: 0,
                  margin: 0,
                  icon: Icons.signal_cellular_alt,
                  color: Colors.transparent,
                ),
                IconCard(
                  title: project.amountOfInvestors,
                  subtitle: "NeoGanaderos",
                  elevation: 0,
                  margin: 0,
                  padding: 0,
                  icon: Icons.people_alt,
                  color: Colors.transparent,
                ),
                const IconCard(
                  title: "\$ ${Constants.minimumInvestment}",
                  titleSpan: "COP",
                  subtitle: "Inversión mínima",
                  elevation: 0,
                  margin: 0,
                  padding: 0,
                  color: Colors.transparent,
                ),
                IconCard(
                  title: "${project.daysLeft} dias",
                  subtitle: "Restantes",
                  elevation: 0,
                  margin: 0,
                  padding: 0,
                  icon: Icons.calendar_month,
                  color: Colors.transparent,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProjectGoalWidget(
                  amountOfCattles: project.amountOfCattles,
                  investmentRequired: project.investmentRequired,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProjectCurrentWidget(
                  investmentCollected: project.investmentCollected,
                  investmentRequired: project.investmentRequired,
                  amountOfCattles: project.amountOfCattles,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProjectProgressIndicator(
                  progress: project.projectProgres,
                ),
                Text("${project.projectProgres} % Recaudado"),
                const SizedBox(
                  height: 10,
                ),
                // if (showMessage)
                //   AlertWarning(
                //     child: Text(
                //       "En caso de no completar el 100% se comprarán los 46 "
                //       "animales actuales y la rentabilidad puede variar "
                //       "un poco",
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         color: Styles.warningColor.withOpacity(0.7),
                //       ),
                //     ),
                //   ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     OutlinedButton(
                //       onPressed: () {},
                //       style: OutlinedButton.styleFrom(
                //         side: BorderSide(
                //           color: Theme.of(context).primaryColor,
                //         ),
                //       ),
                //       child: const Text(
                //         "Participar",
                //       ),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {},
                //       child: const Text(
                //         "Más información",
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
