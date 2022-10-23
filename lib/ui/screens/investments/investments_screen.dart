import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/config/provider/investment_provider.dart';
import 'package:sosty/domain/models/common/enums/shared_preferences_enum.dart';
import 'package:sosty/domain/models/investment/investment_item.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/investments/investments_card.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  _InvestmentsScreenState createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  String? userId;
  Future<List<InvestmentItem>>? futureInvestments;

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString(SharedPreferencesEnum.userId.value) ??
          SharedPreferencesEnum.keyNotFound.value;
    });
  }

  Future<List<InvestmentItem>> _fetchInvestments() async {
    final investmentProvider =
        Provider.of<InvestmentProvider>(context, listen: false);
    return investmentProvider.investmentUseCase
        .getInvestmentsInProgressByInvestor(userId!);
  }

  String _incrementTotalInvested(List<InvestmentItem> investments) {
    int total = investments.fold(
      0,
      (previousValue, element) =>
          previousValue + element.investment.amountInvested,
    );
    return FormatterHelper.money(total);
  }

  Column _getTotalCards(List<InvestmentItem> investments) {
    return Column(
      children: [
        IconCard(
          title: _incrementTotalInvested(investments),
          subtitle: 'Total Invertido',
        ),
        IconCard(
          title: FormatterHelper.money(0),
          subtitle: 'Total Ganancia',
        ),
        IconCard(
          title: FormatterHelper.money(0),
          subtitle: 'Total Recibido',
        ),
        IconCard(
          title: FormatterHelper.money(0),
          subtitle: 'Saldo Sosty',
          tintColor: true,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserId().then((_) {
      futureInvestments = _fetchInvestments();
    });
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
                offsetY: -70.0,
                child: FutureBuilder<List<InvestmentItem>>(
                  future: futureInvestments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            _getTotalCards(snapshot.data!),
                            const SizedBox(
                              height: 20,
                            ),
                            // Show message if there aren't investments
                            (snapshot.data?.isEmpty ?? false)
                                ? const SectionTitle(
                                    title: "Busca proyectos \n para participar",
                                  )
                                : Column(
                                    children: [
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
                                      ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data?.length,
                                        itemBuilder: (context, index) {
                                          InvestmentItem item = snapshot.data![index];
                                          return Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InvestmentsCard(
                                                investmentItem: item,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                          ],
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
