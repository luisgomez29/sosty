class Producer {
  Producer({
    required this.profileDetailsId,
    required this.userId,
    required this.profileType,
    this.isCompany,
    required this.firstName,
    required this.lastName,
    this.companyName,
    this.nit,
    this.documentType,
    required this.documentNumber,
    this.documentUrl,
    required this.contactEmail,
    this.contactCellphone,
    this.contactPhone,
    this.address,
    this.isForeignPerson,
    this.state,
    this.city,
    this.country,
    this.birthDate,
    required this.createDate,
    required this.updateDate,
    this.gender,
    this.description,
    this.patrimonyAmount,
    this.bankAccountNumber,
    this.bankAccountType,
    this.bankAccountBank,
    this.bankAccountCertificationUrl,
    this.producerFormatUrl,
    this.investorFormatUrl,
    this.clientFormatUrl,
    this.rutUrl,
    this.chamberOfCommerceUrl,
    this.declaracionDeRentaUrl,
    this.motivationToInvest,
    this.phraseIdentifiesMe,
    this.knowledgeAboutCattleRaising,
    this.holdingTaxEnabled,
  });

  String profileDetailsId;
  String userId;
  String profileType;
  bool? isCompany;
  String firstName;
  String lastName;
  String? companyName;
  String? nit;
  String? documentType;
  String documentNumber;
  String? documentUrl;
  String contactEmail;
  String? contactCellphone;
  String? contactPhone;
  String? address;
  bool? isForeignPerson;
  String? state;
  String? city;
  String? country;
  DateTime? birthDate;
  DateTime createDate;
  DateTime updateDate;
  String? gender;
  String? description;
  dynamic patrimonyAmount;
  String? bankAccountNumber;
  String? bankAccountType;
  String? bankAccountBank;
  String? bankAccountCertificationUrl;
  String? producerFormatUrl;
  String? investorFormatUrl;
  String? clientFormatUrl;
  String? rutUrl;
  String? chamberOfCommerceUrl;
  String? declaracionDeRentaUrl;
  String? motivationToInvest;
  String? phraseIdentifiesMe;
  String? knowledgeAboutCattleRaising;
  dynamic holdingTaxEnabled;

  factory Producer.fromJson(Map<String, dynamic> json) => Producer(
        profileDetailsId: json["profileDetailsID"],
        userId: json["userID"],
        profileType: json["profileType"],
        isCompany: json["isCompany"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        companyName: json["companyName"],
        nit: json["nit"],
        documentType: json["documentType"],
        documentNumber: json["documentNumber"],
        documentUrl: json["documentUrl"],
        contactEmail: json["contactEmail"],
        contactCellphone: json["contactCellphone"],
        contactPhone: json["contactPhone"],
        address: json["address"],
        isForeignPerson: json["isForeignPerson"],
        state: json["state"],
        city: json["city"],
        country: json["country"],
        birthDate: json['birthDate'] != null
            ? DateTime.parse(json["birthDate"])
            : null,
        createDate: DateTime.parse(json["createDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        gender: json["gender"],
        description: json["description"],
        patrimonyAmount: json["patrimonyAmount"],
        bankAccountNumber: json["bankAccountNumber"],
        bankAccountType: json["bankAccountType"],
        bankAccountBank: json["bankAccountBank"],
        bankAccountCertificationUrl: json["bankAccountCertificationUrl"],
        producerFormatUrl: json["producerFormatUrl"],
        investorFormatUrl: json["investorFormatUrl"],
        clientFormatUrl: json["clientFormatUrl"],
        rutUrl: json["rutUrl"],
        chamberOfCommerceUrl: json["chamberOfCommerceUrl"],
        declaracionDeRentaUrl: json["declaracionDeRentaUrl"],
        motivationToInvest: json["motivationToInvest"],
        phraseIdentifiesMe: json["phraseIdentifiesMe"],
        knowledgeAboutCattleRaising: json["knowledgeAboutCattleRaising"],
        holdingTaxEnabled: json["holdingTaxEnabled"],
      );
}
