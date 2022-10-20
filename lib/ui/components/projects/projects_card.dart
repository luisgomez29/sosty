import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/custom_card.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/screens/investments/investments_detail_screen.dart';

class ProjectsCard extends StatelessWidget {
  const ProjectsCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.estimatedProfitability,
    required this.neoGanaderosCount,
    required this.minimumInvestment,
    required this.hoursLeft,
    required this.animals,
    required this.animalsProgress,
    required this.raisedPercentage,
    required this.progressIndicator,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String estimatedProfitability;
  final String neoGanaderosCount;
  final String minimumInvestment;
  final String hoursLeft;
  final String animals;
  final String animalsProgress;
  final String raisedPercentage;
  final double progressIndicator;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      navigator: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InvestmentsDetail(),
          ),
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              bottom: 30,
              left: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  title,
                  style: Styles.bodyText1Bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                IconCard(
                  title: "$estimatedProfitability % (E.A)",
                  subtitle: "Rentabilidad Estimada*",
                  elevation: 0,
                  padding: 0,
                  margin: 0,
                  icon: Icons.signal_cellular_alt,
                  color: Colors.transparent,
                ),
                IconCard(
                  title: neoGanaderosCount,
                  subtitle: "NeoGanaderos",
                  elevation: 0,
                  margin: 0,
                  padding: 0,
                  icon: Icons.people_alt,
                  color: Colors.transparent,
                ),
                IconCard(
                  title: "\$ $minimumInvestment",
                  titleSpan: "COP",
                  subtitle: "Inversión mínima",
                  elevation: 0,
                  margin: 0,
                  padding: 0,
                  color: Colors.transparent,
                ),
                IconCard(
                  title: "$hoursLeft horas",
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
                Text(animals),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  animalsProgress,
                ),
                const SizedBox(
                  height: 10,
                ),
                LinearProgressIndicator(
                  value: progressIndicator,
                  minHeight: 5,
                  semanticsLabel: 'Progreso',
                ),
                Text("$raisedPercentage % Recaudado"),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  surfaceTintColor: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "En caso de no completar el 100% se comprarán los 46 "
                      "animales actuales y la rentabilidad puede variar "
                      "un poco",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Styles.warningColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: const Text(
                        "Participar",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Más información",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
