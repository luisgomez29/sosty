class Investment {
  Investment({
    required this.investmendId,
    required this.investorId,
    required this.projectId,
    required this.amountInvested,
    this.amountReceived,
    this.contractUrl,
    required this.isConfirmed,
    this.balanceLoaded,
    this.paymentProofUrl,
    this.contratoColaboracionUrl,
    this.contratoMandatoUrl,
    required this.createDate,
    this.deleteDate,
    required this.totalKilograms,
    this.totalCattles,
    required this.reviewMade,
    required this.totalUnits,
    this.epaycoTransactionRef,
    this.epaycoTransactionStatus,
    required this.isPreInvestment,
    required this.agreeToInvestTheBalance,
    required this.balanceToInvest,
    this.allowedToLoadBalance,
  });

  String investmendId;
  String investorId;
  String projectId;
  int amountInvested;
  dynamic amountReceived;
  String? contractUrl;
  bool isConfirmed;
  dynamic balanceLoaded;
  String? paymentProofUrl;
  String? contratoColaboracionUrl;
  String? contratoMandatoUrl;
  DateTime createDate;
  DateTime? deleteDate;
  double totalKilograms;
  double? totalCattles;
  bool reviewMade;
  double totalUnits;
  dynamic epaycoTransactionRef;
  dynamic epaycoTransactionStatus;
  bool isPreInvestment;
  bool agreeToInvestTheBalance;
  int balanceToInvest;
  dynamic allowedToLoadBalance;

  factory Investment.fromJson(Map<String, dynamic> json) => Investment(
        investmendId: json["investmendID"],
        investorId: json["investorID"],
        projectId: json["projectID"],
        amountInvested: json["amountInvested"],
        amountReceived: json["amountReceived"],
        contractUrl: json["contractUrl"],
        isConfirmed: json["isConfirmed"],
        balanceLoaded: json["balanceLoaded"],
        paymentProofUrl: json["paymentProofUrl"],
        contratoColaboracionUrl: json["contratoColaboracionUrl"],
        contratoMandatoUrl: json["contratoMandatoUrl"],
        createDate: DateTime.parse(json["createDate"]),
        deleteDate: json["deleteDate"] != null
            ? DateTime.parse(json["deleteDate"])
            : null,
        totalKilograms: json["totalKilograms"].toDouble(),
        totalCattles: json["totalCattles"]?.toDouble(),
        reviewMade: json["reviewMade"],
        totalUnits: json["totalUnits"].toDouble(),
        epaycoTransactionRef: json["epaycoTransactionRef"],
        epaycoTransactionStatus: json["epaycoTransactionStatus"],
        isPreInvestment: json["isPreInvestment"],
        agreeToInvestTheBalance: json["agreeToInvestTheBalance"],
        balanceToInvest: json["balanceToInvest"],
        allowedToLoadBalance: json["allowedToLoadBalance"],
      );

  Map<String, dynamic> toJson() => {
        "investmendID": investmendId,
        "investorID": investorId,
        "projectID": projectId,
        "amountInvested": amountInvested,
        "amountReceived": amountReceived,
        "contractUrl": contractUrl,
        "isConfirmed": isConfirmed,
        "balanceLoaded": balanceLoaded,
        "paymentProofUrl": paymentProofUrl,
        "contratoColaboracionUrl": contratoColaboracionUrl,
        "contratoMandatoUrl": contratoMandatoUrl,
        "createDate": createDate.toIso8601String(),
        "deleteDate": deleteDate,
        "totalKilograms": totalKilograms,
        "totalCattles": totalCattles,
        "reviewMade": reviewMade,
        "totalUnits": totalUnits,
        "epaycoTransactionRef": epaycoTransactionRef,
        "epaycoTransactionStatus": epaycoTransactionStatus,
        "isPreInvestment": isPreInvestment,
        "agreeToInvestTheBalance": agreeToInvestTheBalance,
        "balanceToInvest": balanceToInvest,
        "allowedToLoadBalance": allowedToLoadBalance,
      };
}
