import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_payment_proj/utils/utils.dart' show removeNullsFromMap;

part 'credit_card.g.dart';

@JsonSerializable(explicitToJson: true)
class CreditCard {
  @JsonKey(name: 'cardNumber')
  final String cardNumber;
  @JsonKey(name: 'expirationDate')
  final String expirationDate; // yyyy-MM format only
  @JsonKey(name: 'cardCode')
  final String cardCode;

  CreditCard(
      {required this.cardNumber,
      required this.expirationDate,
      required this.cardCode});

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);

  Map<String, dynamic>? toJson() =>
      removeNullsFromMap(_$CreditCardToJson(this));
}
