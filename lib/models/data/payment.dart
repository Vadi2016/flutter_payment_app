import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_payment_proj/models/models.dart';
import '../../utils/utils.dart';

part 'payment.g.dart';

@JsonSerializable(explicitToJson: true)
class Payment {
  @JsonKey(name: 'creditCard')
  final CreditCard? creditCard;

  Payment({required this.creditCard});

  factory Payment.creditCard(
      String cardNumber, String expirationDate, String cardCode) {
    return Payment(
      creditCard: CreditCard(
          cardNumber: cardNumber,
          expirationDate: expirationDate,
          cardCode: cardCode),
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic>? toJson() => removeNullsFromMap(_$PaymentToJson(this));
}
