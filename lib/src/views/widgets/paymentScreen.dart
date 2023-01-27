import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xffeeeeee),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image(
                                image: AssetImage('assets/credit_card.png'),
                              ),
                            ),
                          ]),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "VISA card ending ***12",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Regular",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Added on 26th Jan, 2022",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Regular",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            backgroundColor: const Color(0xff042B52),
            onPressed: () {
              //TODO open add card dialog
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Add Payment Method"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Card Number',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Expiry Date',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'CVC',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: SizedBox(
                              width: width / 3.5,
                              child: MaterialButton(
                                onPressed: () {
                                  //TODO add card details
                                },
                                color: const Color(0xff042B52),
                                child: const Text(
                                  "Add Card",
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ));
  }
}
