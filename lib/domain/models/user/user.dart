/// User model
class User {
  final String accessToken;
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
    required this.accessToken,
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

  factory User.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return User(
      accessToken: json['accessToken'],
      userID: user['userID'],
      email: user['email'],
      isLocked: user['isLocked'],
      userType: user['userType'],
      passwordRecoveryCode: user['passwordRecoveryCode'],
      createDate: DateTime.parse(user['createDate']),
      notificationsEnabled: user['notificationsEnabled'],
      emailConfirmationCode: user['emailConfirmationCode'],
      emailConfirmed: user['emailConfirmed'],
      termsAndConditionsAccepted: user['termsAndConditionsAccepted'],
      termsAndConditionsAcceptedDate:
          DateTime.parse(user['termsAndConditionsAcceptedDate']),
      activeCampaignContactId: user['activeCampaignContactId'],
      activeCampaignDealId: user['activeCampaignDealId'],
      activeCampaignDealStatus: user['activeCampaignDealStatus'],
      activeCampaignDealStage: user['activeCampaignDealStage'],
      balance: user['balance'],
      pageCreatedFrom: user['pageCreatedFrom'],
      arrivalChannel: user['arrivalChannel'],
      profilePictureUrl: user['profilePictureUrl'],
      updateDate: user['updateDate'] != null
          ? DateTime.parse(user['updateDate'])
          : null,
      emailConfirmationDate: user['emailConfirmationDate'] != null
          ? DateTime.parse(user['emailConfirmationDate'])
          : null,
    );
  }
}
