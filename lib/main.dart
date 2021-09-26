import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payment_proj/autorize_net.service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widget/input.dart';

void main() {
  runApp(const PaymentService());
}

class PaymentService extends StatelessWidget {
  const PaymentService({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        title: 'Payment service',
        theme: ThemeData(
            primarySwatch: Colors.blue, backgroundColor: Colors.white),
        home: const BankDetailsScreen());
  }
}

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);

  @override
  BankDetailsState createState() => BankDetailsState();
}

class BankDetailsState extends State<BankDetailsScreen> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;
  AuthorizeNetClientService? _clientService;
  String? _refID;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });

    /// Register your sandbox account for testing app on this page:
    /// https://developer.authorize.net/hello_world/sandbox.html
    /// after registration you can put YOUR API LOGIN ID and YOUR TRANSACTION KEY in this field
    _clientService =
        AuthorizeNetClientService('YOUR API LOGIN ID', 'YOUR TRANSACTION KEY');
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Test payments',
                style: TextStyle(color: Colors.black, fontSize: 26),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  CreditCard(
                    cardNumber: cardNumber,
                    cardExpiry: expiryDate,
                    cardHolderName: cardHolderName,
                    cvv: cvv,
                    showBackSide: showBack,
                    frontBackground: CardBackgrounds.black,
                    backBackground: CardBackgrounds.white,
                    showShadow: true,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextInputField(
                    icon: FontAwesomeIcons.creditCard,
                    hint: 'Card Number',
                    inputType: TextInputType.number,
                    inputAction: TextInputAction.next,
                    onChangeCallback: (value) => {
                      setState(() => {cardNumber = value})
                    },
                  ),
                  TextInputField(
                    icon: FontAwesomeIcons.user,
                    hint: 'Card Holder',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.done,
                    onChangeCallback: (value) => {
                      setState(() => {cardHolderName = value})
                    },
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: size.height * 0.07,
                        width: size.width * 1.04 / 2,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 13.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Icon(
                                    FontAwesomeIcons.calendar,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                              hintText: 'MM / YY',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            keyboardType: TextInputType.datetime,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) => {
                              setState(() => {expiryDate = value})
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: size.height * 0.07,
                        width: size.width * 0.5 / 2,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 13.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Icon(
                                    FontAwesomeIcons.solidCreditCard,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                              hintText: 'CVC',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) => {
                              setState(() => {cvv = value})
                            },
                            focusNode: _focusNode,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: 60,
                    color: Colors.black,
                    child: TextButton(
                        onPressed: () async {
                          final response = await _clientService!
                              .authorizeCardPayment('1', 'USD'.toLowerCase(),
                                  cardNumber, expiryDate, cvv);
                          print('response: \n${response.toJson()}');
                          _refID = response.transactionResponse.transId;
                          print(
                              'Reference identifier to search for transactions:'
                              ' $_refID');
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Center(
                      child: Text(
                        'We will debit 1\$ from your account. '
                        'You don\'t have to worry, we will return it.',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
