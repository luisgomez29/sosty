import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/config/api/api_endpoint.dart';
import 'package:sosty/domain/models/investment/investment_item.dart';
import 'package:sosty/ui/common/enums/shared_preferences_enum.dart';
import 'package:sosty/domain/models/error_item/error_item.dart';
import 'package:sosty/domain/models/investment/gateway/investment_gateway.dart';
import 'package:sosty/infraestructure/driven_adapter/investment_api/errors/investment_api_error.dart';
import 'package:sosty/infraestructure/helpers/api_client/api_client.dart';
import 'package:sosty/infraestructure/helpers/api_client/exception/api_exception.dart';

class InvestmentApi extends InvestmentGateway {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<List<InvestmentItem>> getInvestmentsInProgressByInvestor(
    String investorId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken =
        prefs.getString(SharedPreferencesEnum.accessToken.value) ??
            SharedPreferencesEnum.keyNotFound.value;

    final response = await _apiClient.get(
      ApiEndpoint.getInvestmentsInProgressByInvestor,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      params: {'investorID': investorId},
    );

    if (response.status == HttpStatus.ok) {
      Map<String, dynamic> res = jsonDecode(response.body);
      return List<InvestmentItem>.from(
          res["items"].map((x) => InvestmentItem.fromJson(x)));
    } else {
      throw ApiException(
        ErrorItem(
          domain: ApiEndpoint.getInvestmentsInProgressByInvestor,
          reason: response.body,
          message: InvestmentApiError.getInvestmentsInProgressByInvestorFailed,
        ),
      );
    }
  }

  @override
  Future<List<InvestmentItem>> getInvestmentsFinishedByInvestor(
    String investorId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken =
        prefs.getString(SharedPreferencesEnum.accessToken.value) ??
            SharedPreferencesEnum.keyNotFound.value;

    final response = await _apiClient.get(
      ApiEndpoint.getInvestmentsFinishedByInvestor,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      params: {'investorID': investorId},
    );

    if (response.status == HttpStatus.ok) {
      Map<String, dynamic> res = jsonDecode(response.body);
      return List<InvestmentItem>.from(
          res["items"].map((x) => InvestmentItem.fromJson(x)));
    } else {
      throw ApiException(
        ErrorItem(
          domain: ApiEndpoint.getInvestmentsFinishedByInvestor,
          reason: response.body,
          message: InvestmentApiError.getInvestmentsFinishedByInvestorFailed,
        ),
      );
    }
  }
}
