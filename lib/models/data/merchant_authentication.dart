import 'package:json_annotation/json_annotation.dart';

import '../../../utils/utils.dart';

part 'merchant_authentication.g.dart';

@JsonSerializable(explicitToJson: true)
class MerchantAuthentication {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'transactionKey')
  final String transactionKey;

  MerchantAuthentication(this.name, this.transactionKey);

  Map<String, dynamic>? toJson() =>
      removeNullsFromMap(_$MerchantAuthenticationToJson(this));

  factory MerchantAuthentication.fromJson(Map<String, dynamic> json) =>
      _$MerchantAuthenticationFromJson(json);
}
