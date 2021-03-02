import 'package:elgawda/constants/constans.dart';
import 'package:flutter/cupertino.dart';

class HomeCategooriesBody extends StatelessWidget {
  const HomeCategooriesBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customRaiseButtom(
                text: 'C#',
                onTap: () {},
              ),
              customRaiseButtom(
                text: 'c++',
                onTap: () {},
              ),
              customRaiseButtom(
                text: 'C',
                onTap: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customRaiseButtom(
                text: 'Jave Script',
                onTap: () {},
              ),
              customRaiseButtom(
                text: 'HTMLL',
                onTap: () {},
              ),
              customRaiseButtom(
                text: 'CCNN',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
