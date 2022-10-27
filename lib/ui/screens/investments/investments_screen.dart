import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/config/provider/investment_provider.dart';
import 'package:sosty/domain/models/investment/investment_item.dart';
import 'package:sosty/ui/common/enums/shared_preferences_enum.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/investments/investment_card.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  _InvestmentsScreenState createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  String? _userId;
  int? _balance;
  double _totalInvestedInProgress = 0.0;
  double _totalInvestedFinished = 0.0;
  double _totalReceivedFinished = 0.0;
  Future<List<InvestmentItem>>? _futureInvestmentsInProgress;
  Future<List<InvestmentItem>>? _futureInvestmentsFinished;

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString(SharedPreferencesEnum.userId.value) ??
          SharedPreferencesEnum.keyNotFound.value;
      _balance = prefs.getInt(SharedPreferencesEnum.balance.value) ?? 0;
    });
  }

  Future<List<InvestmentItem>> _fetchInvestmentsInProgress() async {
    final investmentProvider =
        Provider.of<InvestmentProvider>(context, listen: false);
    return investmentProvider.investmentUseCase
        .getInvestmentsInProgressByInvestor(_userId!);
  }

  Future<List<InvestmentItem>> _fetchInvestmentsFinished() async {
    final investmentProvider =
        Provider.of<InvestmentProvider>(context, listen: false);
    return investmentProvider.investmentUseCase
        .getInvestmentsFinishedByInvestor(_userId!);
  }

  void _getTotalInvestedInProgress(List<InvestmentItem> investments) {
    int total = investments.fold(
      0,
      (previousValue, element) =>
          previousValue + element.investment.amountInvested,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _totalInvestedInProgress = total.toDouble();
      });
    });
  }

  void _getTotalInvestedFinished(List<InvestmentItem> investments) {
    int total = investments.fold(
      0,
      (previousValue, element) =>
          previousValue + element.investment.amountInvested,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _totalInvestedFinished = total.toDouble();
      });
    });
  }

  void _getTotalReceivedFinished(List<InvestmentItem> investments) {
    double total = 0.0;
    for (var element in investments) {
      if (element.investment.amountReceived != null) {
        total += element.investment.amountReceived!;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _totalReceivedFinished = total;
      });
    });
  }

  String _getTotalGain() {
    double total = _totalReceivedFinished - _totalInvestedFinished;
    return FormatterHelper.money((total > 0.0) ? total : 0.0);
  }

  @override
  void initState() {
    super.initState();
    _loadUserData().then((_) {
      _futureInvestmentsInProgress = _fetchInvestmentsInProgress();
      _futureInvestmentsFinished = _fetchInvestmentsFinished();
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
                child: Column(
                  children: [
                    IconCard(
                      title: FormatterHelper.money(
                        _totalInvestedInProgress + _totalInvestedFinished,
                      ),
                      subtitle: 'Total Invertido',
                    ),
                    IconCard(
                      title: FormatterHelper.money(_totalReceivedFinished),
                      subtitle: 'Total Recibido',
                    ),
                    IconCard(
                      title: _getTotalGain(),
                      subtitle: 'Total Ganancia',
                    ),
                    IconCard(
                      title: FormatterHelper.money(_balance),
                      subtitle: 'Saldo Sosty',
                      tintColor: true,
                    ),
                    FutureBuilder<List<InvestmentItem>>(
                      future: _futureInvestmentsInProgress,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            final bool isEmpty =
                                (snapshot.data?.isEmpty ?? false);
                            if (!isEmpty) {
                              _getTotalInvestedInProgress(snapshot.data!);
                            }
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                // Show message if there aren't investments
                                (isEmpty)
                                    ? const SectionTitle(
                                        title:
                                            "Busca proyectos \n para participar",
                                      )
                                    : Column(
                                        children: [
                                          Divider(
                                            height: 60,
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
                                            itemBuilder: (context, index) =>
                                                Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                InvestmentsCard(
                                                  investmentItem:
                                                      snapshot.data![index],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            if (kDebugMode) {
                              print(
                                "INVESTMENT_IN_PROGRESS_ERROR => ${snapshot.error}",
                              );
                            }
                            return const LoadDataError();
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 30.0,
                          ),
                          child: LoadingIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                    ),
                    FutureBuilder<List<InvestmentItem>>(
                      future: _futureInvestmentsFinished,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData &&
                              (snapshot.data?.isNotEmpty ?? false)) {
                            _getTotalInvestedFinished(snapshot.data!);
                            _getTotalReceivedFinished(snapshot.data!);
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  height: 60,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                  color: Styles.secondaryColor.withOpacity(0.1),
                                ),
                                const SectionTitle(
                                  title: "Inversiones Finializadas",
                                ),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InvestmentsCard(
                                        investmentItem: snapshot.data![index],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            if (kDebugMode) {
                              print(
                                  "INVESTMENT_FINISHED_ERROR => ${snapshot.error}");
                            }
                            return const LoadDataError();
                          }
                        }
                        return const SizedBox();
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
