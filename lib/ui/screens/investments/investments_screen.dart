import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/investments/investments_card.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

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
                offsetY: -70.0,
                child: Column(
                  children: [
                    const IconCard(
                      title: '\$ 1’000.000',
                      subtitle: 'Total Invertido',
                    ),
                    const IconCard(
                      title: '\$ 140.000',
                      subtitle: 'Total Ganancia',
                    ),
                    const IconCard(
                      title: '\$ 140.000',
                      subtitle: 'Total Recibido',
                    ),
                    const IconCard(
                      title: '\$ 1’000.000',
                      subtitle: 'Saldo Sosty',
                      tintColor: true,
                    ),
                    Divider(
                      height: 50,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                      color: Styles.secondaryColor.withOpacity(0.1),
                    ),
                    Column(
                      children: const [
                        SectionTitle(
                          title: "Inversiones actuales",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InvestmentsCard(
                          title: "Proyecto de Prueba - No Invertir",
                          code: "1110",
                          location: "Finca El Origen, Meta",
                          progress: "1,306.09 de 50,000.00 Kg (2.61%)",
                          progressIndicator: 0.3,
                          investedAmount: "1'000.000",
                          participation: '137.21 Kg (10.51%)',
                          paymentConfirmed: true,
                          phase: "Ejecución",
                        ),
                        InvestmentsCard(
                          title: "Proyecto de Prueba - No Invertir",
                          code: "1110",
                          location: "Finca El Origen, Meta",
                          progress: "1,306.09 de 50,000.00 Kg (2.61%)",
                          progressIndicator: 0.3,
                          investedAmount: "1'000.000",
                          participation: '137.21 Kg (10.51%)',
                          paymentConfirmed: true,
                          phase: "Ejecución",
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