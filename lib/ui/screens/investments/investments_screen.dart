import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/app_bottom_navigation_bar.dart';
import 'package:sosty/config/provider/InvestmentProvider.dart';
import 'package:sosty/domain/models/Item/item.dart';
import 'package:sosty/domain/models/common/enums/shared_preferences_enum.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/investments/investments_card.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';
import 'package:sosty/ui/screens/projets/project_screen.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  _InvestmentsScreenState createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  String userId = "";
  final totalInvestedText = 'Total Invertido';
  final totalGain = 'Total Ganancia';
  final totalReceivedText = 'Total Recibido';
  final balanceSostyText = 'Saldo Sosty';

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString(SharedPreferencesEnum.userId.value) ??
          SharedPreferencesEnum.keyNotFound.value;
    });
  }

  double _getPercent(double investmentCollected, int investmentRequired) {
    return investmentCollected / investmentRequired;
  }

  String _getProgress(double investmentCollected, int investmentRequired) {
    final String percent =
        (_getPercent(investmentCollected, investmentRequired) * 100.0)
            .toStringAsFixed(2);
    return '${investmentCollected.toStringAsFixed(2)} de '
        '${FormatterHelper.money(investmentRequired)} Kg ($percent%)';
  }

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  @override
  Widget build(BuildContext context) {
    final investmentProvider = Provider.of<InvestmentProvider>(context);
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
                    FutureBuilder<List<Item>>(
                      future: investmentProvider.investmentUseCase
                          .getInvestmentsInProgressByInvestor(userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            if (snapshot.data?.isEmpty ?? false) {
                              return Column(
                                children: [
                                  IconCard(
                                    title: FormatterHelper.money(0),
                                    subtitle: totalInvestedText,
                                  ),
                                  IconCard(
                                    title: FormatterHelper.money(0),
                                    subtitle: totalGain,
                                  ),
                                  IconCard(
                                    title: FormatterHelper.money(0),
                                    subtitle: totalReceivedText,
                                  ),
                                  IconCard(
                                    title: FormatterHelper.money(0),
                                    subtitle: balanceSostyText,
                                    tintColor: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SectionTitle(
                                    title: "Busca proyectos \n para invertir",
                                  ),
                                ],
                              );
                            }
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                Item item = snapshot.data![index];
                                return Column(
                                  children: [
                                    IconCard(
                                      title: FormatterHelper.money(
                                        item.investment.amountInvested,
                                      ),
                                      subtitle: totalInvestedText,
                                    ),
                                    IconCard(
                                      title: FormatterHelper.money(
                                        item.investment.amountReceived,
                                      ),
                                      subtitle: totalGain,
                                    ),
                                    IconCard(
                                      title: FormatterHelper.money(
                                        item.investment.amountReceived,
                                      ),
                                      subtitle: totalReceivedText,
                                    ),
                                    IconCard(
                                      title: FormatterHelper.money(
                                        item.investment.balanceToInvest,
                                      ),
                                      subtitle: balanceSostyText,
                                      tintColor: true,
                                    ),
                                    Divider(
                                      height: 50,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 0,
                                      color: Styles.secondaryColor
                                          .withOpacity(0.1),
                                    ),
                                    const SectionTitle(
                                      title: "Inversiones actuales",
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InvestmentsCard(
                                      title: item.project.projectName,
                                      code: item.project.projectCode,
                                      location:
                                          "${item.project.locationAddress}, ${item.project.locationState}",
                                      progress: _getProgress(
                                        item.project.investmentCollected,
                                        item.project.investmentRequired,
                                      ),
                                      progressIndicator: _getPercent(
                                        item.project.investmentCollected,
                                        item.project.investmentRequired,
                                      ),
                                      investedAmount: FormatterHelper.money(
                                        item.investment.amountInvested,
                                      ),
                                      participation:
                                          item.investment.totalKilograms,
                                      investmentDate:
                                          item.investment.createDate,
                                      paymentConfirmed:
                                          item.investment.isConfirmed,
                                      phase: item.project.projectStatus,
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            if (kDebugMode) {
                              print("INVESTMENT_ERROR => ${snapshot.error}");
                            }
                            return const LoadDataError();
                          }
                        }
                        return const LoadingIndicator();
                      },
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
