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

  final String investmendId;
  final String investorId;
  final String projectId;
  final int amountInvested;
  final double? amountReceived;
  final String? contractUrl;
  final bool isConfirmed;
  final double? balanceLoaded;
  final String? paymentProofUrl;
  final String? contratoColaboracionUrl;
  final String? contratoMandatoUrl;
  final DateTime createDate;
  final DateTime? deleteDate;
  final double totalKilograms;
  final double? totalCattles;
  final bool reviewMade;
  final double totalUnits;
  final dynamic epaycoTransactionRef;
  final dynamic epaycoTransactionStatus;
  final bool isPreInvestment;
  final bool agreeToInvestTheBalance;
  final int balanceToInvest;
  final dynamic allowedToLoadBalance;

  factory Investment.fromJson(Map<String, dynamic> json) => Investment(
        investmendId: json["investmendID"],
        investorId: json["investorID"],
        projectId: json["projectID"],
        amountInvested: json["amountInvested"],
        amountReceived: json["amountReceived"]?.toDouble(),
        contractUrl: json["contractUrl"],
        isConfirmed: json["isConfirmed"],
        balanceLoaded: json["balanceLoaded"]?.toDouble(),
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
