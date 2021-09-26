import 'package:flutter_payment_proj/models/models.dart';

Map<T, R>? removeNullsFromMap<T, R>(Map<T, R> map) {
  if (map.isEmpty) return null;
  map.removeWhere((key, value) => value == null);
  return map;
}

bool verifyTransactionSuccess(CreateTransactionResponse response) {
  final errorMessages = response.transactionResponse.errors;

  return (errorMessages == null || errorMessages.isEmpty) &&
      verifySuccessCode(response.messages);
}

bool verifySuccessCode(ResponseMessages messages) {
  final resultCode = messages.resultCode;
  return resultCode == ResponseMessages.STATUS_OK;
}

String get uniqueReferenceID => '${DateTime.now().millisecondsSinceEpoch}';
