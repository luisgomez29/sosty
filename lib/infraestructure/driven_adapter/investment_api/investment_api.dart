import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/config/api/api_endpoint.dart';
import 'package:sosty/domain/models/Item/item.dart';
import 'package:sosty/domain/models/error_item/error_item.dart';
import 'package:sosty/domain/models/investment/gateway/investment_gateway.dart';
import 'package:sosty/infraestructure/driven_adapter/investment_api/errors/investment_error_api.dart';
import 'package:sosty/infraestructure/helpers/api_client/api_client.dart';
import 'package:sosty/infraestructure/helpers/api_client/exception/api_exception.dart';
import 'package:sosty/ui/common/constants/constants.dart';

class InvestmentApi extends InvestmentGateway {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<List<Item>> getInvestmentsInProgressByInvestor(
      String investorID) async {
    final prefs = await SharedPreferences.getInstance();

    final accessToken = prefs.getString(Constants.accessTokenPref) ??
        Constants.keyPreferenceNotFound;

    final response = await _apiClient.get(
      ApiEndpoint.getInvestmentsInProgressByInvestor,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      params: {'investorID': investorID},
    );

    if (response.status == HttpStatus.ok) {
      Map<String, dynamic> res = jsonDecode(response.body);
      return List<Item>.from(res["items"].map((x) => Item.fromJson(x)));
    } else {
      throw ApiException(
        ErrorItem(
          domain: ApiEndpoint.login,
          reason: response.body,
          message: InvestmentErrorApi.getInvestmentsInProgressByInvestorFailed,
        ),
      );
    }
  }
}
