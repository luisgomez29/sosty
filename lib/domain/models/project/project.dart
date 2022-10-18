class Project {
  Project({
    required this.projectId,
    required this.producerId,
    required this.projectName,
    required this.projectCode,
    required this.projectStatus,
    this.projectVideoUrl,
    required this.projectImageUrl1,
    this.projectImageUrl2,
    this.projectImageUrl3,
    this.projectImageUrl4,
    required this.investmentRequired,
    required this.minimumInvestmentRequired,
    required this.investmentCollected,
    required this.collectDeadline,
    required this.createDate,
    required this.updateDate,
    this.deleteDate,
    this.submitDate,
    required this.startDate,
    required this.endDate,
    required this.details,
    required this.risksManagement,
    required this.communicationPlan,
    this.objectivesAndDetails,
    required this.projectType,
    required this.projectSex,
    required this.projectCattleType,
    required this.cattleWeightAverageGain,
    required this.totalBatchWeight,
    required this.amountOfCattles,
    required this.projectProfitability,
    this.hasSostyAudit,
    this.hasSostyInsurance,
    required this.farmName,
    required this.locationAddress,
    required this.locationState,
    this.locationCity,
    this.locationArrivalLIndications,
    this.locationSize,
    required this.producerCommission,
    required this.estimatedFreightCost,
    this.locationLatitude,
    this.locationLongitude,
    this.locationIsRented,
    this.financialProjectionUrl,
    required this.libertadYTradicionCertificateUrl,
    this.usoDelSueloCertificateUrl,
    this.registroSanitarioUrl,
    this.ultimoSoporteVacunacionUrl,
    this.contratoDeArriendoUrl,
    required this.contratoColaboracionUrl,
    required this.contratoPrestacionServiciosUrl,
    required this.determinantesRiesgosAmbientalesYSocialesUrl,
    required this.suraRelacionHatoGanaderoUrl,
    this.suraDeclaracionBovinoUrl,
    this.suraDeclaracionTipoDeProductorUrl,
    this.suraCotizacionSeguroUrl,
    required this.sostyComission,
    required this.initialKilogramPrice,
    required this.finalKilogramPrice,
    required this.initialWeight,
    required this.finalWeight,
    required this.projectStory,
    required this.insurancePricePerKilogram,
    required this.totalMoneyCollected,
    required this.mandatoPercentage,
    required this.isBlockedForInvestment,
    required this.fourPerThousandPerKilogram,
    required this.orejerasPerKilogram,
    required this.totalPricePerKilogram,
    required this.sostyComissionOnSale,
    required this.calvesPercentage,
    required this.calveWeigthAtWeaning,
    required this.amountOfBulls,
    required this.amountOfCows,
    required this.totalCostCows,
    required this.totalCostBulls,
    required this.totalFreightCost,
    required this.totalInsurance,
    required this.totalOrejeras,
    required this.totalFourPerThousand,
    required this.totalSostyComercialization,
    required this.totalCostBreedingProject,
    required this.totalUnits,
    required this.unitPrice,
    this.calvesRevenue,
    this.liquidationRevenue,
    this.amountOfCalvesToSell,
    required this.whatsappGroupLink,
    required this.rutNotificationSent,
    required this.clickUpTaskId,
  });

  String projectId;
  String producerId;
  String projectName;
  String projectCode;
  String projectStatus;
  String? projectVideoUrl;
  String projectImageUrl1;
  String? projectImageUrl2;
  String? projectImageUrl3;
  String? projectImageUrl4;
  int investmentRequired;
  int minimumInvestmentRequired;
  double investmentCollected;
  DateTime collectDeadline;
  DateTime createDate;
  DateTime updateDate;
  DateTime? deleteDate;
  DateTime? submitDate;
  DateTime startDate;
  DateTime endDate;
  String details;
  String risksManagement;
  String communicationPlan;
  String? objectivesAndDetails;
  String projectType;
  String projectSex;
  String projectCattleType;
  int cattleWeightAverageGain;
  int totalBatchWeight;
  int amountOfCattles;
  double projectProfitability;
  bool? hasSostyAudit;
  bool? hasSostyInsurance;
  String farmName;
  String locationAddress;
  String locationState;
  String? locationCity;
  String? locationArrivalLIndications;
  String? locationSize;
  int producerCommission;
  int estimatedFreightCost;
  double? locationLatitude;
  double? locationLongitude;
  bool? locationIsRented;
  String? financialProjectionUrl;
  String libertadYTradicionCertificateUrl;
  String? usoDelSueloCertificateUrl;
  String? registroSanitarioUrl;
  String? ultimoSoporteVacunacionUrl;
  String? contratoDeArriendoUrl;
  String contratoColaboracionUrl;
  String contratoPrestacionServiciosUrl;
  String determinantesRiesgosAmbientalesYSocialesUrl;
  String suraRelacionHatoGanaderoUrl;
  String? suraDeclaracionBovinoUrl;
  String? suraDeclaracionTipoDeProductorUrl;
  String? suraCotizacionSeguroUrl;
  int sostyComission;
  int initialKilogramPrice;
  int finalKilogramPrice;
  int initialWeight;
  int finalWeight;
  String projectStory;
  int insurancePricePerKilogram;
  int totalMoneyCollected;
  int mandatoPercentage;
  bool isBlockedForInvestment;
  int fourPerThousandPerKilogram;
  int orejerasPerKilogram;
  int totalPricePerKilogram;
  int sostyComissionOnSale;
  int calvesPercentage;
  int calveWeigthAtWeaning;
  int amountOfBulls;
  int amountOfCows;
  int totalCostCows;
  int totalCostBulls;
  int totalFreightCost;
  int totalInsurance;
  int totalOrejeras;
  int totalFourPerThousand;
  int totalSostyComercialization;
  int totalCostBreedingProject;
  int totalUnits;
  double unitPrice;
  dynamic calvesRevenue;
  dynamic liquidationRevenue;
  dynamic amountOfCalvesToSell;
  String whatsappGroupLink;
  bool rutNotificationSent;
  String clickUpTaskId;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectId: json["projectID"],
        producerId: json["producerID"],
        projectName: json["projectName"],
        projectCode: json["projectCode"],
        projectStatus: json["projectStatus"],
        projectVideoUrl: json["projectVideoUrl"],
        projectImageUrl1: json["projectImageUrl1"],
        projectImageUrl2: json["projectImageUrl2"],
        projectImageUrl3: json["projectImageUrl3"],
        projectImageUrl4: json["projectImageUrl4"],
        investmentRequired: json["investmentRequired"],
        minimumInvestmentRequired: json["minimumInvestmentRequired"],
        investmentCollected: json["investmentCollected"].toDouble(),
        collectDeadline: DateTime.parse(json["collectDeadline"]),
        createDate: DateTime.parse(json["createDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        deleteDate: json["deleteDate"] != null
            ? DateTime.parse(json["deleteDate"])
            : null,
        submitDate: json["submitDate"] != null
            ? DateTime.parse(json["submitDate"])
            : null,
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        details: json["details"],
        risksManagement: json["risksManagement"],
        communicationPlan: json["communicationPlan"],
        objectivesAndDetails: json["objectivesAndDetails"],
        projectType: json["projectType"],
        projectSex: json["projectSex"],
        projectCattleType: json["projectCattleType"],
        cattleWeightAverageGain: json["cattleWeightAverageGain"],
        totalBatchWeight: json["totalBatchWeight"],
        amountOfCattles: json["amountOfCattles"],
        projectProfitability: json["projectProfitability"].toDouble(),
        hasSostyAudit: json["hasSostyAudit"],
        hasSostyInsurance: json["hasSostyInsurance"],
        farmName: json["farmName"],
        locationAddress: json["locationAddress"],
        locationState: json["locationState"],
        locationCity: json["locationCity"],
        locationArrivalLIndications: json["locationArrivalLIndications"],
        locationSize: json["locationSize"],
        producerCommission: json["producerCommission"],
        estimatedFreightCost: json["estimatedFreightCost"],
        locationLatitude: json["locationLatitude"],
        locationLongitude: json["locationLongitude"],
        locationIsRented: json["locationIsRented"],
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
        projectStory: json["projectStory"],
        insurancePricePerKilogram: json["insurancePricePerKilogram"],
        totalMoneyCollected: json["totalMoneyCollected"],
        mandatoPercentage: json["mandatoPercentage"],
        isBlockedForInvestment: json["isBlockedForInvestment"],
        fourPerThousandPerKilogram: json["fourPerThousandPerKilogram"],
        orejerasPerKilogram: json["orejerasPerKilogram"],
        totalPricePerKilogram: json["totalPricePerKilogram"],
        sostyComissionOnSale: json["sostyComissionOnSale"],
        calvesPercentage: json["calvesPercentage"],
        calveWeigthAtWeaning: json["calveWeigthAtWeaning"],
        amountOfBulls: json["amountOfBulls"],
        amountOfCows: json["amountOfCows"],
        totalCostCows: json["totalCostCows"],
        totalCostBulls: json["totalCostBulls"],
        totalFreightCost: json["totalFreightCost"],
        totalInsurance: json["totalInsurance"],
        totalOrejeras: json["totalOrejeras"],
        totalFourPerThousand: json["totalFourPerThousand"],
        totalSostyComercialization: json["totalSostyComercialization"],
        totalCostBreedingProject: json["totalCostBreedingProject"],
        totalUnits: json["totalUnits"],
        unitPrice: json["unitPrice"].toDouble(),
        calvesRevenue: json["calvesRevenue"],
        liquidationRevenue: json["liquidationRevenue"],
        amountOfCalvesToSell: json["amountOfCalvesToSell"],
        whatsappGroupLink: json["whatsappGroupLink"],
        rutNotificationSent: json["rutNotificationSent"],
        clickUpTaskId: json["clickUpTaskID"],
      );
}
