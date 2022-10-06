import 'package:sosty_app/domain/models/user/user.dart';
import 'package:sosty_app/infraestructure/helpers/maps/commons/base_mapper.dart';

class UserMapper implements BaseMapper<User> {
  @override
  fromMap(Map<String, dynamic> json) => User(
        userID: json['userID'],
        email: json['email'],
        isLocked: json['isLocked'],
        userType: json['userType'],
        passwordRecoveryCode: json['passwordRecoveryCode'],
        createDate: json['createDate'],
        notificationsEnabled: json['notificationsEnabled'],
        emailConfirmationCode: json['emailConfirmationCode'],
        emailConfirmed: json['emailConfirmed'],
        termsAndConditionsAccepted: json['termsAndConditionsAccepted'],
        termsAndConditionsAcceptedDate: json['termsAndConditionsAcceptedDate'],
        activeCampaignContactId: json['activeCampaignContactId'],
        activeCampaignDealId: json['activeCampaignDealId'],
        activeCampaignDealStatus: json['activeCampaignDealStatus'],
        activeCampaignDealStage: json['activeCampaignDealStage'],
        balance: json['balance'],
        pageCreatedFrom: json['pageCreatedFrom'],
        arrivalChannel: json['arrivalChannel'],
        profilePictureUrl: json['profilePictureUrl'],
        updateDate: json['updateDate'],
        emailConfirmationDate: json['emailConfirmationDate'],
      );
}