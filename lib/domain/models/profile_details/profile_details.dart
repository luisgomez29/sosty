/// ProfileDetails model
class ProfileDetails {
  final String profileDetailsID;
  final String userID;
  final String profileType;
  final String contactEmail;
  final String contactCellphone;
  final String firstName;
  final String lastName;
  final DateTime createDate;
  final bool? isCompany;
  final String? companyName;
  final String? nit;
  final String? documentType;
  final String? documentNumber;
  final String? documentUrl;
  final String? contactPhone;
  final String? address;
  final bool? isForeignPerson;
  final String? state;
  final String? city;
  final String? country;
  final DateTime? birthDate;
  final DateTime? updateDate;
  final String? gender;
  final String? description;
  final String? patrimonyAmount;
  final String? producerFormatUrl;
  final String? investorFormatUrl;
  final String? clientFormatUrl;
  final String? rutUrl;
  final String? chamberOfCommerceUrl;
  final String? declaracionDeRentaUrl;
  final String? motivationToInvest;
  final String? phraseIdentifiesMe;
  final String? knowledgeAboutCattleRaising;
  final String? holdingTaxEnable;

  ProfileDetails({
    required this.profileDetailsID,
    required this.userID,
    required this.profileType,
    required this.contactEmail,
    required this.contactCellphone,
    required this.firstName,
    required this.lastName,
    required this.createDate,
    this.isCompany,
    this.companyName,
    this.nit,
    this.documentType,
    this.documentNumber,
    this.documentUrl,
    this.contactPhone,
    this.address,
    this.isForeignPerson,
    this.state,
    this.city,
    this.country,
    this.birthDate,
    this.updateDate,
    this.gender,
    this.description,
    this.patrimonyAmount,
    this.producerFormatUrl,
    this.investorFormatUrl,
    this.clientFormatUrl,
    this.rutUrl,
    this.chamberOfCommerceUrl,
    this.declaracionDeRentaUrl,
    this.motivationToInvest,
    this.phraseIdentifiesMe,
    this.knowledgeAboutCattleRaising,
    this.holdingTaxEnable,
  });
}
