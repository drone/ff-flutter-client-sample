import 'package:flutter/material.dart';
import 'dart:math';
import 'FeatureType.dart';


class _NeedHelpView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(child: Transform.rotate(
      angle:  -pi/2,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text("Need help ? 👋",
              style: TextStyle(color: Colors.white, fontSize: 22.0)),
        ),
      ),
    )
    );
  }
}


class FetureListItem extends StatefulWidget {
  final FeatureCard card;

  FetureListItem({Key key, this.card}) : super(key: key);

  @override
  _FeatureListItem createState() => _FeatureListItem(this.card);

}

class _FeatureListItem extends State<FetureListItem> {

  FeatureCard card;

  _FeatureListItem(this.card);


  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(color: card.enabledDarkMode ? Colors.white : Colors.black);
    if (card.isHelpEnabled) {
      return _NeedHelpView();
    }
    if (!card.available) {
      return Container(
          color: card.enabledDarkMode ? Colors.black : Colors.white);
    }
    return Container(
      color: card.enabledDarkMode ? Colors.black : Colors.white,
      child: Card(
          color: card.enabledDarkMode ? Colors.black : Colors.white,
          child: Stack(children: [
            Column(children: [
              Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage(card.featureImageName)
                      ),
                    ),
                  )

              ),
              Padding(padding: EdgeInsets.all(10),
                  child: Text(card.featureDescription, style: style)),
              Container(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(card.featureTrialPeriod.toString() +
                              ' - Day Trial', style: style),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))
                              ),
                              shadowColor: card.enabledDarkMode ? Colors.white : Colors.black,
                              backgroundColor: card.enabledDarkMode ? Colors.black : Colors.white,
                              elevation: 5,
                            ),
                            onPressed: () {
                              print('something something');
                            }
                            , child: Text('Enable'))
                      ],)),
              ),
            ],
            ),
            Positioned(
                top: 0,
                right: 0,
                width: 40,
                height: 40,
                child: !card.hasRibbon ? Container() : Image.asset(
                    'assets/images/new.png'))
          ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          shadowColor: card.enabledDarkMode ? Colors.white : Colors.black
      ),
    );
  }
}





