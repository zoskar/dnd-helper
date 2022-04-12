import 'package:flutter/material.dart';

class InfoPageRoute extends MaterialPageRoute<InfoPage> {
  InfoPageRoute()
      : super(
          builder: (context) => const InfoPage(),
        );
}

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          
        ),
        body: const InfoBody(),
      );
}

class InfoBody extends StatelessWidget {
  const InfoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: 100,
            width: 200,
            color: Colors.amber,
          ),
        ),
      );
}
