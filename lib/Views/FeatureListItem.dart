  import 'package:flutter/material.dart';
  import 'FeatureType.dart';


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
      return !card.available ? Container() : Container(
        color: card.enabledDarkMode ? Colors.black : Colors.white,
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(children: [
              Column(children: [
                Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
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
                    child: Text(card.featureDescription)),
                Container(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child:
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text( card.featureTrialPeriod.toString()  + ' - Day Trial'),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5))),
                                shadowColor: Colors.black,
                                backgroundColor: Colors.white,
                                elevation: 5,
                              ),
                              onPressed: () {
                                print('something something');
                              }
                              , child: Text('Enabled'))
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
            margin: EdgeInsets.all(10)
        ),
      );
    }
  }


