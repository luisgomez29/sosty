/// ProfileDetail model
class ProfileDetail {
  ProfileDetail({
    required this.profileDetailsId,
    required this.userId,
    required this.profileType,
    this.isCompany,
    required this.firstName,
    required this.lastName,
    this.companyName,
    this.nit,
    this.documentType,
    this.documentNumber,
    this.documentUrl,
    required this.contactEmail,
    required this.contactCellphone,
    this.contactPhone,
    this.address,
    this.isForeignPerson,
    this.state,
    this.city,
    this.country,
    this.birthDate,
    required this.createDate,
    this.updateDate,
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

  final String profileDetailsId;
  final String userId;
  final String profileType;
  final bool? isCompany;
  final String firstName;
  final String lastName;
  final String? companyName;
  final String? nit;
  final String? documentType;
  final String? documentNumber;
  final String? documentUrl;
  final String? contactEmail;
  final String contactCellphone;
  final String? contactPhone;
  final String? address;
  final bool? isForeignPerson;
  final String? state;
  final String? city;
  final String? country;
  final DateTime? birthDate;
  final DateTime createDate;
  final DateTime? updateDate;
  final String? gender;
  final String? description;
  final dynamic patrimonyAmount;
  final dynamic bankAccountNumber;
  final dynamic bankAccountType;
  final dynamic bankAccountBank;
  final String? bankAccountCertificationUrl;
  final String? producerFormatUrl;
  final String? investorFormatUrl;
  final String? clientFormatUrl;
  final String? rutUrl;
  final String? chamberOfCommerceUrl;
  final String? declaracionDeRentaUrl;
  final String? motivationToInvest;
  final String? phraseIdentifiesMe;
  final dynamic knowledgeAboutCattleRaising;
  final bool? holdingTaxEnabled;

  factory ProfileDetail.fromJson(Map<String, dynamic> json) => ProfileDetail(
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
            ? DateTime.parse(json['birthDate'])
            : null,
        createDate: DateTime.parse(json["createDate"]),
        updateDate: json['updateDate'] != null
            ? DateTime.parse(json['updateDate'])
            : null,
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
