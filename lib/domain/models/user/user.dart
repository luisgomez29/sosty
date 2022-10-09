/// User model
class User {
  final String userID;
  final String email;
  final bool isLocked;
  final String userType;
  final int passwordRecoveryCode;
  final DateTime createDate;
  final bool notificationsEnabled;
  final String emailConfirmationCode;
  final bool emailConfirmed;
  final bool termsAndConditionsAccepted;
  final DateTime termsAndConditionsAcceptedDate;
  final String activeCampaignContactId;
  final String activeCampaignDealId;
  final int activeCampaignDealStatus;
  final String activeCampaignDealStage;
  final String? password;
  final int? balance;
  final String? pageCreatedFrom;
  final String? arrivalChannel;
  final DateTime? emailConfirmationDate;
  final String? profilePictureUrl;
  final DateTime? updateDate;

  User({
    required this.userID,
    required this.email,
    required this.isLocked,
    required this.userType,
    required this.passwordRecoveryCode,
    required this.createDate,
    required this.notificationsEnabled,
    required this.emailConfirmationCode,
    required this.emailConfirmed,
    required this.termsAndConditionsAccepted,
    required this.termsAndConditionsAcceptedDate,
    required this.activeCampaignContactId,
    required this.activeCampaignDealId,
    required this.activeCampaignDealStatus,
    required this.activeCampaignDealStage,
    this.balance,
    this.pageCreatedFrom,
    this.arrivalChannel,
    this.password,
    this.profilePictureUrl,
    this.updateDate,
    this.emailConfirmationDate,
  });
}
