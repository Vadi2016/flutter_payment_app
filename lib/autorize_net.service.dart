import 'dart:convert';

import 'models/models.dart';
import 'utils/network_utils.dart';
import 'utils/utils.dart';

class AuthorizeNetClientService {
  /// String value which represents merchant name(API ID) of the client
  final String merchantName;

  /// String value which represents transaction key(API SECRET) of the client
  final String transactionKey;

  AuthorizeNetClientService._(this.merchantName, this.transactionKey);

  /// static instance to implement singleton pattern
  static AuthorizeNetClientService? _instance;

  factory AuthorizeNetClientService(
      String merchantName,
      String transactionKey) {
    _instance ??= AuthorizeNetClientService._(
          merchantName,
          transactionKey
      );
    return _instance!;
  }

  String get baseApi => 'https://apitest.authorize.net/xml/v1/request.api';

  MerchantAuthentication get merchantAuthentication =>
      MerchantAuthentication(merchantName, transactionKey);

  Future<AuthenticationTestResponse> authenticationTest() async {
    final authenticationTestRequest =
    AuthenticationTestRequest(merchantAuthentication);

    var responseJson = await executeRequest(
      baseApi,
      authenticationTestRequest.getRequestJson(),
    );
    final response =
    AuthenticationTestResponse.fromJson(jsonDecode(responseJson!));
    return response;
  }

  Future<CreateTransactionResponse> chargeCreditCard(
      String amount,
      String currencyCode,
      String cardNumber,
      String expirationDate,
      String cardCode, {
        String? referenceID,
      }) async {
    final transactionRequest = TransactionRequest.authCaptureTransaction(amount,
        currencyCode, Payment.creditCard(cardNumber, expirationDate, cardCode));
    final createTransactionRequest = CreateTransactionRequest(
      merchantAuthentication,
      referenceID: referenceID ?? uniqueReferenceID,
      transactionRequest: transactionRequest,
    );

    var responseJson = await executeRequest(
      baseApi,
      createTransactionRequest.getRequestJson(),
    );
    final response =
    CreateTransactionResponse.fromJson(jsonDecode(responseJson!));
    return response;
  }

  Future<CreateTransactionResponse> authorizeCardPayment(
      String amount,
      String currencyCode,
      String cardNumber,
      String expirationDate,
      String cardCode, {
        String? referenceID,
      }) async {
    final transactionRequest = TransactionRequest.authOnlyTransaction(amount,
        currencyCode, Payment.creditCard(cardNumber, expirationDate, cardCode));
    final createTransactionRequest = CreateTransactionRequest(
      merchantAuthentication,
      referenceID: referenceID ?? uniqueReferenceID,
      transactionRequest: transactionRequest,
    );

    var responseJson = await executeRequest(
      baseApi,
      createTransactionRequest.getRequestJson(),
    );
    final response =
    CreateTransactionResponse.fromJson(jsonDecode(responseJson!));
    return response;
  }

  Future<CreateTransactionResponse> priorAuthCaptureTransaction(
      String amount,
      String currencyCode,
      String referenceTransactionID, {
        String? referenceID,
      }) async {
    final transactionRequest = TransactionRequest.priorAuthCaptureTransaction(
      amount,
      currencyCode,
      referenceTransactionID,
    );
    final createTransactionRequest = CreateTransactionRequest(
      merchantAuthentication,
      referenceID: referenceID ?? uniqueReferenceID,
      transactionRequest: transactionRequest,
    );

    var responseJson = await executeRequest(
      baseApi,
      createTransactionRequest.getRequestJson(),
    );
    final response =
    CreateTransactionResponse.fromJson(jsonDecode(responseJson!));
    return response;
  }


  Future<CreateTransactionResponse> voidTransaction(
      String referenceTransactionID, {
        String? referenceID,
      }) async {
    final transactionRequest = TransactionRequest.voidTransaction(
      referenceTransactionID,
    );
    final createTransactionRequest = CreateTransactionRequest(
      merchantAuthentication,
      referenceID: referenceID ?? uniqueReferenceID,
      transactionRequest: transactionRequest,
    );

    var responseJson = await executeRequest(
      baseApi,
      createTransactionRequest.getRequestJson(),
    );
    final response =
    CreateTransactionResponse.fromJson(jsonDecode(responseJson!));
    return response;
  }
}
