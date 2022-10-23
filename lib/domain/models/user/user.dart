import 'package:sosty/domain/models/common/enums/user_role_enum.dart';
import 'package:sosty/domain/models/user/profile_detail.dart';

/// User model
class User {
  User({
    required this.accessToken,
    required this.userId,
    required this.email,
    this.profilePictureUrl,
    required this.isLocked,
    required this.userType,
    required this.passwordRecoveryCode,
    required this.createDate,
    this.updateDate,
    required this.notificationsEnabled,
    required this.profileDetails,
    required this.projects,
    this.truoraCheckId,
    this.truoraCheckScore,
    this.truoraPdf,
    this.truoraCheckDate,
    required this.emailConfirmationCode,
    required this.emailConfirmed,
    this.emailConfirmationDate,
    required this.termsAndConditionsAccepted,
    required this.termsAndConditionsAcceptedDate,
    required this.activeCampaignContactId,
    required this.activeCampaignDealId,
    required this.activeCampaignDealStatus,
    required this.activeCampaignDealStage,
    this.balance,
    this.pageCreatedFrom,
    this.arrivalChannel,
    this.siigoCustomerId,
    this.siigoCustomerStatus,
    this.siigoCustomerStatusMessage,
  });

  final String accessToken;
  final String userId;
  final String email;
  final String? profilePictureUrl;
  final bool isLocked;
  final UserRoleEnum userType;
  final int passwordRecoveryCode;
  final DateTime createDate;
  final DateTime? updateDate;
  final bool notificationsEnabled;
  final List<ProfileDetail> profileDetails;
  final dynamic projects;
  final String? truoraCheckId;
  final double? truoraCheckScore;
  final String? truoraPdf;
  final DateTime? truoraCheckDate;
  final String emailConfirmationCode;
  final bool emailConfirmed;
  final DateTime? emailConfirmationDate;
  final bool termsAndConditionsAccepted;
  final DateTime termsAndConditionsAcceptedDate;
  final String activeCampaignContactId;
  final String activeCampaignDealId;
  final int activeCampaignDealStatus;
  final String activeCampaignDealStage;
  final int? balance;
  final String? pageCreatedFrom;
  final dynamic arrivalChannel;
  final String? siigoCustomerId;
  final String? siigoCustomerStatus;
  final String? siigoCustomerStatusMessage;

  factory User.fromJson(Map<String, dynamic> json) {
    final userJson = json.containsKey("user") ? json['user'] : json;
    return User(
      accessToken: json.containsKey("accessToken") ? json['accessToken'] : "",
      userId: userJson["userID"],
      email: userJson["email"],
      profilePictureUrl: userJson["profilePictureUrl"],
      isLocked: userJson["isLocked"],
      userType: UserRoleEnum.values.firstWhere(
        (e) => e.value == userJson["userType"],
      ),
      passwordRecoveryCode: userJson["passwordRecoveryCode"],
      createDate: DateTime.parse(userJson["createDate"]),
      updateDate: userJson['updateDate'] != null
          ? DateTime.parse(userJson['updateDate'])
          : null,
      notificationsEnabled: userJson["notificationsEnabled"],
      profileDetails: userJson["profileDetails"] == null
          ? []
          : List<ProfileDetail>.from(
              userJson["profileDetails"].map(
                (x) => ProfileDetail.fromJson(x),
              ),
            ),
      projects: userJson["projects"],
      truoraCheckId: userJson["truoraCheckId"],
      truoraCheckScore: userJson['truoraCheckScore'] != null
          ? userJson["truoraCheckScore"].toDouble()
          : null,
      truoraPdf: userJson["truoraPdf"],
      truoraCheckDate: userJson["truoraCheckDate"] != null
          ? DateTime.parse(userJson["truoraCheckDate"])
          : null,
      emailConfirmationCode: userJson["emailConfirmationCode"],
      emailConfirmed: userJson["emailConfirmed"],
      emailConfirmationDate: userJson['emailConfirmationDate'] != null
          ? DateTime.parse(userJson['emailConfirmationDate'])
          : null,
      termsAndConditionsAccepted: userJson["termsAndConditionsAccepted"],
      termsAndConditionsAcceptedDate:
          DateTime.parse(userJson["termsAndConditionsAcceptedDate"]),
      activeCampaignContactId: userJson["activeCampaignContactId"],
      activeCampaignDealId: userJson["activeCampaignDealId"],
      activeCampaignDealStatus: userJson["activeCampaignDealStatus"],
      activeCampaignDealStage: userJson["activeCampaignDealStage"],
      balance: userJson["balance"],
      pageCreatedFrom: userJson["pageCreatedFrom"],
      arrivalChannel: userJson["arrivalChannel"],
      siigoCustomerId: userJson["siigoCustomerID"],
      siigoCustomerStatus: userJson["siigoCustomerStatus"],
      siigoCustomerStatusMessage: userJson["siigoCustomerStatusMessage"],
    );
  }
}
