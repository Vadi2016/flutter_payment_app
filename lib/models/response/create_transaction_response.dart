import 'package:json_annotation/json_annotation.dart';

import '../../utils/utils.dart';
import '../data/response_messages.dart';
import 'transaction_response.dart';

part 'create_transaction_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateTransactionResponse {
  @JsonKey(name: 'transactionResponse')
  final TransactionResponse transactionResponse;
  @JsonKey(name: 'messages')
  final ResponseMessages messages;

  CreateTransactionResponse(this.transactionResponse, this.messages);

  factory CreateTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateTransactionResponseFromJson(json);

  Map<String, dynamic>? toJson() =>
      removeNullsFromMap(_$CreateTransactionResponseToJson(this));

  bool get isSuccessful => verifyTransactionSuccess(this);
}
