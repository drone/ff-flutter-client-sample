import 'dart:ui';
import 'dart:async';
import 'FeaturesView.dart';
import 'package:flutter/material.dart';

import 'package:ff_flutter_client_sdk/CfClient.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const String apiKey = "YOUR_API_KEY";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Text(
                'Choose your account',
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(padding: EdgeInsets.all(10)),
              new ListTile(
                  title: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Aptiv',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .fontSize)))),
                  onTap: () async {
                    // Navigator push new view
                    _onLoading();
                    var isInitialazed = await selectedAccount('Aptiv');
                    Navigator.pop(context);
                    if (isInitialazed) {
                      var navigationResult = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeatureView('Aptiv')));
                      if (navigationResult == false) {
                        //navigation failed
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Server not reachable'),
                                ));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Server not reachable'),
                              ));
                    }
                  }),
              Padding(padding: EdgeInsets.all(10)),
              new ListTile(
                  title: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Experian',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .fontSize)))),
                  onTap: () async {
                    // Navigator push new view
                    _onLoading();
                    var isInitialazed = await selectedAccount('Experian');
                    Navigator.pop(context);
                    if (isInitialazed) {
                      var navigationResult = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeatureView('Experian')));
                      if (navigationResult == false) {
                        //navigation failed
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Server not reachable'),
                                ));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Server not reachable'),
                              ));
                    }
                  }),
              Padding(padding: EdgeInsets.all(10)),
              new ListTile(
                  title: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Fiserv',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .fontSize)))),
                  onTap: () async {
                    // Navigator push new view
                    _onLoading();
                    var isInitialazed = await selectedAccount('Fiserv');
                    Navigator.pop(context);
                    if (isInitialazed) {
                      var navigationResult = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeatureView('Fiserv')));
                      if (navigationResult == false) {
                        //navigation failed
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Server not reachable'),
                                ));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Server not reachable'),
                              ));
                    }
                  }),
              Padding(padding: EdgeInsets.all(10)),
              new ListTile(
                  title: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Harness',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .fontSize)))),
                  onTap: () async {
                    // Navigator push new view
                    _onLoading();
                    var isInitialazed = await selectedAccount('Harness');
                    Navigator.pop(context);
                    if (isInitialazed) {
                      var navigationResult = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeatureView('Harness')));
                      if (navigationResult == false) {
                        //navigation failed
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Server not reachable'),
                                ));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Server not reachable'),
                              ));
                    }
                  }),
              Padding(padding: EdgeInsets.all(10)),
              new ListTile(
                  title: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Palo Alto Networks',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .fontSize)))),
                  onTap: () async {
                    // Navigator push new view
                    _onLoading();
                    var isInitialazed =
                        await selectedAccount('Palo Alto Networks');
                    Navigator.pop(context);
                    if (isInitialazed) {
                      var navigationResult = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FeatureView('Palo Alto Networks')));
                      if (navigationResult == false) {
                        //navigation failed
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Server not reachable'),
                                ));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Server not reachable'),
                              ));
                    }
                  }),
              Padding(padding: EdgeInsets.all(10)),
            ])));
  }

  Future<bool> selectedAccount(String name) async {
    var conf = CfConfigurationBuilder()
        .setStreamEnabled(true)
        .setAnalyticsEnabled(true)
        // .setConfigUri("https://config.feature-flags.uat.harness.io/api/1.0")
        // .setStreamUrl(
        //     "https://config.feature-flags.uat.harness.io/api/1.0/stream")
        // .setEventUrl("https://event.feature-flags.uat.harness.io/api/1.0")
        .build();

    var target = CfTargetBuilder().setIdentifier(name).build();

    CfClient.getInstance().registerEventsListener((data, eventType) {
      print("Event: " + eventType.toString());
    });

    var res = await CfClient.getInstance().initialize(apiKey, conf, target);
    return res.success;
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 100,
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new CircularProgressIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new Text("initializing..."),
                ),
              ],
            ),
          ),
        );
      },
    );
    //   new Future.delayed(new Duration(seconds: 3), () {
    //     Navigator.pop(context); //pop dialog
    //   });
    // }
  }
}
