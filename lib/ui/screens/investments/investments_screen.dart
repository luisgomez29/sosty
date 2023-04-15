import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/config/provider/investment_provider.dart';
import 'package:sosty/domain/models/investment/investment_item.dart';
import 'package:sosty/ui/common/enums/shared_preferences_enum.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/components/cards/icon_card.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/general/section_title.dart';
import 'package:sosty/ui/components/investments/investment_card.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';
import 'package:sosty/ui/screens/auth/login_screen.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen>
    with AutomaticKeepAliveClientMixin {
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
      _userId = prefs.getString(SharedPreferencesEnum.userId.value);
      _balance = prefs.getInt(SharedPreferencesEnum.balance.value) ?? 0;
    });
  }

  Future<void> _fetchInvestmentsInProgress() async {
    final investmentProvider =
        Provider.of<InvestmentProvider>(context, listen: false);
    final res = investmentProvider.investmentUseCase
        .getInvestmentsInProgressByInvestor(_userId!);
    setState(() {
      _futureInvestmentsInProgress = res;
    });
  }

  Future<void> _fetchInvestmentsFinished() async {
    final investmentProvider =
        Provider.of<InvestmentProvider>(context, listen: false);
    final res = investmentProvider.investmentUseCase
        .getInvestmentsFinishedByInvestor(_userId!);
    setState(() {
      _futureInvestmentsFinished = res;
    });
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

  void _goToScreen(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  void initState() {
    super.initState();
    _loadUserData().then((_) {
      if (_userId != null) {
        _fetchInvestmentsInProgress();
        _fetchInvestmentsFinished();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        if (_userId != null) {
          _fetchInvestmentsInProgress();
          _fetchInvestmentsFinished();
        }
      },
      child: CustomScrollView(
        slivers: <Widget>[
          const Navbar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const NavbarClipper(),
                ContentSection(
                  offsetY: -60.0,
                  child: _userId == null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 300.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Para ver tus invesiones por favor inicia sesión",
                                textAlign: TextAlign.center,
                                style: Styles.headline3,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              LargeButton(
                                text: "Iniciar sesión",
                                onPressed: () => _goToScreen(
                                  const LoginScreen(),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            IconCard(
                              title: FormatterHelper.money(
                                _totalInvestedInProgress +
                                    _totalInvestedFinished,
                              ),
                              subtitle: 'Total Invertido',
                            ),
                            IconCard(
                              title:
                                  FormatterHelper.money(_totalReceivedFinished),
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
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    final bool isEmpty =
                                        (snapshot.data?.isEmpty ?? false);
                                    if (!isEmpty) {
                                      _getTotalInvestedInProgress(
                                          snapshot.data!);
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
                                                    title:
                                                        "Inversiones actuales",
                                                  ),
                                                  ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        snapshot.data?.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        InvestmentsCard(
                                                          investmentItem:
                                                              snapshot
                                                                  .data![index],
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
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
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
                                          color: Styles.secondaryColor
                                              .withOpacity(0.1),
                                        ),
                                        const SectionTitle(
                                          title: "Inversiones Finializadas",
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
