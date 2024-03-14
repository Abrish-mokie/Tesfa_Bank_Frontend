import 'package:flutter/material.dart';
import 'package:front_end/widgets/drop_down_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: AccordionCard()),
    );
  }
}
