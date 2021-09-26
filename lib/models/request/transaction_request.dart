import 'package:json_annotation/json_annotation.dart';

import '../../utils/utils.dart';
import '../data/additional_charge.dart';
import '../data/address.dart';
import '../data/payment.dart';

part 'transaction_request.g.dart';

/// A model that represents transaction request data
///
/// Important transaction data like, [transactionType], [amount], [currencyCode],
/// [payment] are included in this model.
///
/// Some additional data is also included in this model:
///  - additional charges: [tax], [duty], [shipping]
///  - addresses: [billTo] & [shipTo]
@JsonSerializable(explicitToJson: true)
class TransactionRequest {
  static const String TAG_AUTH_CAPTURE_TRANSACTION = 'authCaptureTransaction';
  static const String TAG_AUTH_ONLY_TRANSACTION = 'authOnlyTransaction';
  static const String TAG_CAPTURE_PRE_AUTH_TRANSACTION =
      'priorAuthCaptureTransaction';
  static const String TAG_REFUND_TRANSACTION = 'refundTransaction';
  static const String TAG_VOID_TRANSACTION = 'voidTransaction';

  @JsonKey(name: 'transactionType')
  final String? transactionType;
  @JsonKey(name: 'amount')
  final String? amount; // int based value
  @JsonKey(name: 'currencyCode')
  final String? currencyCode; // ISO-4217, 3 char currency code
  @JsonKey(name: 'payment')
  final Payment? payment;
  @JsonKey(name: 'refTransId')
  final String? refTransId;
  @JsonKey(name: 'tax')
  final AdditionalCharge? tax;
  @JsonKey(name: 'duty')
  final AdditionalCharge? duty;
  @JsonKey(name: 'shipping')
  final AdditionalCharge? shipping;
  @JsonKey(name: 'billTo')
  final Address? billTo;
  @JsonKey(name: 'shipTo')
  final Address? shipTo;

  TransactionRequest(
    this.transactionType, {
    this.amount,
    this.currencyCode,
    this.payment,
    this.refTransId,
    this.billTo,
    this.shipTo,
    this.tax,
    this.duty,
    this.shipping,
  });

  /// Factory constructor for creating a request to Charge the Credit card
  factory TransactionRequest.authCaptureTransaction(
    String amount,
    String currencyCode,
    Payment payment, {
    Address? billTo,
    Address? shipTo,
    AdditionalCharge? tax,
    AdditionalCharge? duty,
    AdditionalCharge? shipping,
  }) {
    return TransactionRequest(TAG_AUTH_CAPTURE_TRANSACTION,
        amount: amount,
        currencyCode: currencyCode,
        payment: payment,
        billTo: billTo,
        shipTo: shipTo,
        tax: tax,
        duty: duty,
        shipping: shipping);
  }

  /// Factory constructor for creating a request to pre-authorize a transaction
  factory TransactionRequest.authOnlyTransaction(
    String amount,
    String currencyCode,
    Payment payment, {
    Address? billTo,
    Address? shipTo,
    AdditionalCharge? tax,
    AdditionalCharge? duty,
    AdditionalCharge? shipping,
  }) {
    return TransactionRequest(
      TAG_AUTH_ONLY_TRANSACTION,
      amount: amount,
      currencyCode: currencyCode,
      payment: payment,
      billTo: billTo,
      shipTo: shipTo,
      tax: tax,
      duty: duty,
      shipping: shipping,
      refTransId: '',
    );
  }

  factory TransactionRequest.priorAuthCaptureTransaction(
      String amount, String currencyCode, String referenceTransactionID) {
    return TransactionRequest(
      TAG_CAPTURE_PRE_AUTH_TRANSACTION,
      amount: amount,
      currencyCode: currencyCode,
      refTransId: referenceTransactionID,
    );
  }

  factory TransactionRequest.refundTransaction(String amount,
      String currencyCode, Payment payment, String referenceTransactionID) {
    return TransactionRequest(
      TAG_REFUND_TRANSACTION,
      amount: amount,
      currencyCode: currencyCode,
      payment: payment,
      refTransId: referenceTransactionID,
    );
  }

  factory TransactionRequest.voidTransaction(String referenceTransactionID) {
    return TransactionRequest(
      TAG_VOID_TRANSACTION,
      refTransId: referenceTransactionID,
    );
  }

  factory TransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionRequestFromJson(json);

  Map<String, dynamic>? toJson() =>
      removeNullsFromMap(_$TransactionRequestToJson(this));
}
