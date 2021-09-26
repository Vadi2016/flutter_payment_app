// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTransactionResponse _$CreateTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    CreateTransactionResponse(
      TransactionResponse.fromJson(
          json['transactionResponse'] as Map<String, dynamic>),
      ResponseMessages.fromJson(json['messages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateTransactionResponseToJson(
        CreateTransactionResponse instance) =>
    <String, dynamic>{
      'transactionResponse': instance.transactionResponse.toJson(),
      'messages': instance.messages.toJson(),
    };
