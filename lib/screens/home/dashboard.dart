import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/models/transaction.dart';
import 'package:front_end/widgets/drop_down_card.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

// Transacion list
  final List<Transaction> transactionList = [
    Transaction(
      name: 'Robert Fox',
      date: '23 January 2021',
      amount: '-396.84',
    ),
    Transaction(
      name: 'Robert Fox',
      date: '23 January 2021',
      amount: '-396.84',
    ),
    Transaction(
      name: 'Robert Fox',
      date: '23 January 2021',
      amount: '-396.84',
    ),
    Transaction(
      name: 'Robert Fox',
      date: '23 January 2021',
      amount: '-396.84',
    ),
    Transaction(
      name: 'Robert Fox',
      date: '23 January 2021',
      amount: '-396.84',
    ),
    Transaction(
      name: 'Robert Fox',
      date: '23 January 2021',
      amount: '-396.84',
    ),
    Transaction(
      name: 'Robert Fox',
      date: '23 January 2021',
      amount: '-396.84',
    ),
    Transaction(
      name: 'berhan Adhana',
      date: '23 January 2021',
      amount: '-396.84',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            AccordionCard(),
            // Qucik access buttons

            CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    quickButtons(() {}, "Send", Icons.send, isangled: true),
                    quickButtons(
                        () {}, "Transfer", Icons.transfer_within_a_station),
                    quickButtons(() {}, "Pay", Icons.payment),
                    quickButtons(() {}, "Deposit", Icons.qr_code),
                  ],
                ),
              ),
            ),
            // Recent contact section

            CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SeeAll(
                          label: "Send to ",
                          buttonLabel: "See all",
                          onPressed: () {}),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            quickButtons(
                              () {},
                              "Add Reciver",
                              Icons.add,
                            ),
                            quickButtons(() {}, "Jim ", null,
                                imageUri:
                                    "assets/images/dummy/image-placeholder-2.png"),
                            quickButtons(() {}, "Kim ", null,
                                imageUri:
                                    "assets/images/dummy/image-placeholder-3.png"),
                            quickButtons(() {}, "Bil ", null,
                                imageUri:
                                    "assets/images/dummy/image-placeholder-1.png"),
                            quickButtons(() {}, "Phi", null,
                                imageUri:
                                    "assets/images/dummy/image-placeholder.png"),
                            quickButtons(() {}, "Sia ", null,
                                imageUri:
                                    "assets/images/dummy/image-placeholder-1.png"),
                            quickButtons(() {}, "Lia", null,
                                imageUri:
                                    "assets/images/dummy/image-placeholder.png"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SeeAll(
                          label: "History Transaction ",
                          buttonLabel: "See all",
                          onPressed: () {}),
                      Expanded(
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: transactionList.length,
                          itemBuilder: (context, index) {
                            final transaction = transactionList[index];
                            return ListTile(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg:
                                        "${transaction.name} transaction is clicked");
                              },
                              leading: Image.asset(
                                  "assets/images/dummy/image-placeholder-1.png"),
                              title: Text(transaction.name),
                              subtitle: Text(
                                transaction.date,
                                style: const TextStyle(color: Colors.black45),
                              ),
                              trailing: Text(
                                "\$" + transaction.amount,
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget quickButtons(Function onPressed, String label, IconData? icon,
      {bool isangled = false, String? imageUri}) {
    return Column(
      children: [
        CustomContainer(
            image: imageUri,
            child: Transform(
              alignment: Alignment.center,
              transform:
                  isangled ? Matrix4.rotationZ(12) : Matrix4.rotationZ(0),
              // origin: Offset.zero,
              child: IconButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "clicked");
                  },
                  icon: Icon(icon)),
            )),
        Text(
          label,
          style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
        ),
      ],
    );
  }
}

class _SeeAll extends StatelessWidget {
  const _SeeAll({
    super.key,
    required this.label,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String label;
  final String buttonLabel;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      TextButton(
        onPressed: onPressed(),
        child: Text(buttonLabel,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).hintColor)),
      ),
    ]);
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      color: Colors.white,
      shadowColor: Colors.grey,
      surfaceTintColor: Colors.transparent,
      elevation: 5.0,
      child: child,
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;
  final String? image;

  const CustomContainer({super.key, required this.child, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          image: image == null
              ? null
              : DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(image ?? "")),
          border: Border.all(width: 2.0, color: Colors.black12),
          borderRadius: BorderRadius.circular(8.0)),
      width: 56,
      height: 56,
      child: child,
    );
  }
}
