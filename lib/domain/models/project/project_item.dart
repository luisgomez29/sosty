class ProjectItem {
  ProjectItem({
    required this.projectId,
    this.projectVideoUrl,
    required this.projectImageUrl1,
    this.projectImageUrl2,
    this.projectImageUrl3,
    this.projectImageUrl4,
    required this.projectName,
    required this.projectCode,
    required this.amountOfInvestors,
    required this.projectProfitability,
    required this.daysLeft,
    required this.startDate,
    this.endDate,
    this.lastWeigthDate,
    required this.projectDuration,
    required this.locationSize,
    required this.producerCommission,
    required this.investmentRequired,
    required this.investmentCollected,
    required this.projectProgres,
    required this.projectStatus,
    required this.amountOfCattles,
    required this.totalBatchWeight,
    required this.estimatedFreightCost,
    required this.cattleWeightAverageGain,
    required this.projectType,
    required this.projectSex,
    required this.projectCattleType,
    required this.totalProjectWeigthGain,
    required this.producerName,
    required this.producerId,
    this.producerProfilePictureUrl,
    required this.locationAddress,
    this.farmName,
    required this.locationArrivalLIndications,
    required this.details,
    required this.risksManagement,
    required this.communicationPlan,
    required this.projectStory,
    required this.financialProjectionUrl,
    this.libertadYTradicionCertificateUrl,
    this.usoDelSueloCertificateUrl,
    this.registroSanitarioUrl,
    this.ultimoSoporteVacunacionUrl,
    this.contratoDeArriendoUrl,
    required this.contratoColaboracionUrl,
    this.contratoPrestacionServiciosUrl,
    required this.determinantesRiesgosAmbientalesYSocialesUrl,
    this.suraRelacionHatoGanaderoUrl,
    this.suraDeclaracionBovinoUrl,
    this.suraDeclaracionTipoDeProductorUrl,
    this.suraCotizacionSeguroUrl,
    required this.sostyComission,
    required this.initialKilogramPrice,
    required this.finalKilogramPrice,
    required this.initialWeight,
    required this.finalWeight,
    required this.insurancePricePerKilogram,
    required this.mandatoPercentage,
    this.isBlockedForInvestment,
    required this.totalMoneyCollected,
    this.fourPerThousandPerKilogram,
    this.orejerasPerKilogram,
    this.totalPricePerKilogram,
    this.sostyComissionOnSale,
    this.calvesPercentage,
    this.calveWeigthAtWeaning,
    this.amountOfBulls,
    this.amountOfCows,
    this.totalCostCows,
    this.totalCostBulls,
    this.totalFreightCost,
    this.totalInsurance,
    this.totalOrejeras,
    this.totalFourPerThousand,
    this.totalSostyComercialization,
    this.totalCostBreedingProject,
    this.totalUnits,
    this.unitPrice,
    this.calvesRevenue,
    this.liquidationRevenue,
    this.amountOfCalvesToSell,
    this.whatsappGroupLink,
    this.invoicesCreated,
  });

  final String projectId;
  final String? projectVideoUrl;
  final String projectImageUrl1;
  final String? projectImageUrl2;
  final String? projectImageUrl3;
  final String? projectImageUrl4;
  final String projectName;
  final String projectCode;
  final String amountOfInvestors;
  final String projectProfitability;
  final String daysLeft;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? lastWeigthDate;
  final String projectDuration;
  final String locationSize;
  final String producerCommission;
  final String investmentRequired;
  final String investmentCollected;
  final String projectProgres;
  final String projectStatus;
  final String amountOfCattles;
  final String totalBatchWeight;
  final String estimatedFreightCost;
  final String cattleWeightAverageGain;
  final String projectType;
  final String projectSex;
  final String projectCattleType;
  final int totalProjectWeigthGain;
  final String producerName;
  final String producerId;
  final String? producerProfilePictureUrl;
  final String locationAddress;
  final String? farmName;
  final String locationArrivalLIndications;
  final String details;
  final String risksManagement;
  final String communicationPlan;
  final String projectStory;
  final String financialProjectionUrl;
  final String? libertadYTradicionCertificateUrl;
  final String? usoDelSueloCertificateUrl;
  final String? registroSanitarioUrl;
  final String? ultimoSoporteVacunacionUrl;
  final String? contratoDeArriendoUrl;
  final String contratoColaboracionUrl;
  final String? contratoPrestacionServiciosUrl;
  final String determinantesRiesgosAmbientalesYSocialesUrl;
  final String? suraRelacionHatoGanaderoUrl;
  final String? suraDeclaracionBovinoUrl;
  final String? suraDeclaracionTipoDeProductorUrl;
  final String? suraCotizacionSeguroUrl;
  final int sostyComission;
  final int initialKilogramPrice;
  final int finalKilogramPrice;
  final int initialWeight;
  final int finalWeight;
  final double insurancePricePerKilogram;
  final double mandatoPercentage;
  final bool? isBlockedForInvestment;
  final double totalMoneyCollected;
  final double? fourPerThousandPerKilogram;
  final double? orejerasPerKilogram;
  final double? totalPricePerKilogram;
  final double? sostyComissionOnSale;
  final double? calvesPercentage;
  final dynamic calveWeigthAtWeaning;
  final int? amountOfBulls;
  final int? amountOfCows;
  final double? totalCostCows;
  final double? totalCostBulls;
  final double? totalFreightCost;
  final double? totalInsurance;
  final int? totalOrejeras;
  final double? totalFourPerThousand;
  final double? totalSostyComercialization;
  final double? totalCostBreedingProject;
  final int? totalUnits;
  final double? unitPrice;
  final dynamic calvesRevenue;
  final dynamic liquidationRevenue;
  final int? amountOfCalvesToSell;
  final String? whatsappGroupLink;
  final dynamic invoicesCreated;

  factory ProjectItem.fromJson(Map<String, dynamic> json) => ProjectItem(
        projectId: json["projectID"],
        projectVideoUrl: json["projectVideoUrl"],
        projectImageUrl1: json["projectImageUrl1"],
        projectImageUrl2: json["projectImageUrl2"],
        projectImageUrl3: json["projectImageUrl3"],
        projectImageUrl4: json["projectImageUrl4"],
        projectName: json["projectName"],
        projectCode: json["projectCode"],
        amountOfInvestors: json["amountOfInvestors"],
        projectProfitability: json["projectProfitability"],
        daysLeft: json["daysLeft"],
        startDate: DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        lastWeigthDate: json["lastWeigthDate"] != null
            ? DateTime.parse(json["lastWeigthDate"])
            : null,
        projectDuration: json["projectDuration"],
        locationSize: json["locationSize"],
        producerCommission: json["producerCommission"],
        investmentRequired: json["investmentRequired"],
        investmentCollected: json["investmentCollected"],
        projectProgres: json["projectProgres"],
        projectStatus: json["projectStatus"],
        amountOfCattles: json["amountOfCattles"],
        totalBatchWeight: json["totalBatchWeight"],
        estimatedFreightCost: json["estimatedFreightCost"],
        cattleWeightAverageGain: json["cattleWeightAverageGain"],
        projectType: json["projectType"],
        projectSex: json["projectSex"],
        projectCattleType: json["projectCattleType"],
        totalProjectWeigthGain: json["totalProjectWeigthGain"],
        producerName: json["producerName"],
        producerId: json["producerID"],
        producerProfilePictureUrl: json["producerProfilePictureUrl"],
        locationAddress: json["locationAddress"],
        farmName: json["farmName"],
        locationArrivalLIndications: json["locationArrivalLIndications"],
        details: json["details"],
        risksManagement: json["risksManagement"],
        communicationPlan: json["communicationPlan"],
        projectStory: json["projectStory"],
        financialProjectionUrl: json["financialProjectionUrl"],
        libertadYTradicionCertificateUrl:
            json["libertadYTradicionCertificateUrl"],
        usoDelSueloCertificateUrl: json["usoDelSueloCertificateUrl"],
        registroSanitarioUrl: json["registroSanitarioUrl"],
        ultimoSoporteVacunacionUrl: json["ultimoSoporteVacunacionUrl"],
        contratoDeArriendoUrl: json["contratoDeArriendoUrl"],
        contratoColaboracionUrl: json["contratoColaboracionUrl"],
        contratoPrestacionServiciosUrl: json["contratoPrestacionServiciosUrl"],
        determinantesRiesgosAmbientalesYSocialesUrl:
            json["determinantesRiesgosAmbientalesYSocialesUrl"],
        suraRelacionHatoGanaderoUrl: json["suraRelacionHatoGanaderoUrl"],
        suraDeclaracionBovinoUrl: json["suraDeclaracionBovinoUrl"],
        suraDeclaracionTipoDeProductorUrl:
            json["suraDeclaracionTipoDeProductorUrl"],
        suraCotizacionSeguroUrl: json["suraCotizacionSeguroUrl"],
        sostyComission: json["sostyComission"],
        initialKilogramPrice: json["initialKilogramPrice"],
        finalKilogramPrice: json["finalKilogramPrice"],
        initialWeight: json["initialWeight"],
        finalWeight: json["finalWeight"],
        insurancePricePerKilogram: json["insurancePricePerKilogram"].toDouble(),
        mandatoPercentage: json["mandatoPercentage"].toDouble(),
        isBlockedForInvestment: json["isBlockedForInvestment"],
        totalMoneyCollected: json["totalMoneyCollected"].toDouble(),
        fourPerThousandPerKilogram: json["fourPerThousandPerKilogram"],
        orejerasPerKilogram: json["orejerasPerKilogram"]?.toDouble(),
        totalPricePerKilogram: json["totalPricePerKilogram"]?.toDouble(),
        sostyComissionOnSale: json["sostyComissionOnSale"]?.toDouble(),
        calvesPercentage: json["calvesPercentage"]?.toDouble(),
        calveWeigthAtWeaning: json["calveWeigthAtWeaning"],
        amountOfBulls: json["amountOfBulls"],
        amountOfCows: json["amountOfCows"],
        totalCostCows: json["totalCostCows"]?.toDouble(),
        totalCostBulls: json["totalCostBulls"]?.toDouble(),
        totalFreightCost: json["totalFreightCost"]?.toDouble(),
        totalInsurance: json["totalInsurance"]?.toDouble(),
        totalOrejeras: json["totalOrejeras"],
        totalFourPerThousand: json["totalFourPerThousand"]?.toDouble(),
        totalSostyComercialization:
            json["totalSostyComercialization"]?.toDouble(),
        totalCostBreedingProject: json["totalCostBreedingProject"]?.toDouble(),
        totalUnits: json["totalUnits"],
        unitPrice: json["unitPrice"]?.toDouble(),
        calvesRevenue: json["calvesRevenue"],
        liquidationRevenue: json["liquidationRevenue"],
        amountOfCalvesToSell: json["amountOfCalvesToSell"],
        whatsappGroupLink: json["whatsappGroupLink"],
        invoicesCreated: json["invoicesCreated"],
      );
}
