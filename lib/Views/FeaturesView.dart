import 'package:flutter/material.dart';
import 'dart:ui';
import 'FeatureListItem.dart';
import 'FeatureType.dart';
import 'package:ff_flutter_client_sdk/CfClient.dart';
import 'package:sticky_headers/sticky_headers.dart';
// ignore: must_be_immutable
class FeatureView extends StatelessWidget {

  String title;
  FeatureView(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('$title'),
        actions: [
          TextButton(onPressed: () { this._destroyTapped(context); },
              child: Text('Destroy',
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold))
          )
        ],
      ),
      body: FeaturesGrid(),
    );
  }

  _destroyTapped(BuildContext context) {
    CfClient.destroy();
    Navigator.pop(context);
  }
}

class FeaturesGrid extends StatefulWidget {
  FeaturesGrid({Key key}) : super(key: key);

  @override
  _FeaturesGrid createState() => _FeaturesGrid();
}

class _FeaturesGrid extends State<FeaturesGrid> {
  List<FeatureCard> features = [CDModule(),NeedHelp(),CVModule(), CIModule(), CEModule(), CFModule()];
  List<String> listHeader = [
    'Enabled Modules',
    'Enable More Modules',
  ];

  bool  _enabledDarkMode = false;
  Function _eventListener;

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: _enabledDarkMode ? Colors.black : Colors.white,
      child: new ListView.builder(
    itemCount: listHeader.length, itemBuilder: (context, index) {
      return new StickyHeader(
        header: new Container(
          height: 38.0,
          color: Colors.white,
          padding: new EdgeInsets.symmetric(horizontal: 12.0),
          alignment: Alignment.centerLeft,
          child: new Text(listHeader[index],
            style: const TextStyle(color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        content: Container(
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: getListForIndex(index).length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (contxt, indx) {
              return SizedBox(height: double.infinity,
                  child: FetureListItem(card: getListForIndex(index)[indx]));
            }
            )
        )
      );
    },
      shrinkWrap: true,
    ));
  }

  List getListForIndex(index)  {
    if (index == 0) {
      return features.sublist(0,2).toList();
    }else {
      return features.sublist(2).toList();
    }
  }
  @override
  void initState() {
    super.initState();
    _registerForEvents();
    parseEvaluationFlagFromCache("harnessappdemoenableglobalhelp");
    parseEvaluationFlagFromCache("harnessappdemoenablecvmodule");
    parseEvaluationFlagFromCache("harnessappdemoenablecimodule");
    parseEvaluationFlagFromCache("harnessappdemoenablecfmodule");
    parseEvaluationFlagFromCache("harnessappdemoenablecemodule");
    parseEvaluationFlagFromCache("harnessappdemodarkmode");
    parseEvaluationFlagFromCache("harnessappdemocfribbon");
    parseEvaluationFlagFromCache("harnessappdemocvtriallimit");
    parseEvaluationFlagFromCache("harnessappdemocitriallimit");
    parseEvaluationFlagFromCache("harnessappdemocftriallimit");
    parseEvaluationFlagFromCache("harnessappdemocetriallimit");
  }

  @override
  void dispose() {
    super.dispose();
    CfClient.unregisterEventsListener(_eventListener);
    CfClient.destroy();
  }

  _registerForEvents() {
    CfClient.registerEventsListener((evaluationMap, eventType) {
      _eventListener = (evaluationMap, eventType){};
      switch (eventType) {
        case EventType.SSE_START:
          print("Started SSE");
          break;
        case EventType.SSE_END:
          print("SSE Completed");
          break;
        case EventType.EVALUATION_CHANGE:
          String flag = (evaluationMap as EvaluationResponse).flag;
          dynamic value = (evaluationMap as EvaluationResponse).value;
          parseEvaluationFlag(flag, value);
          break;
        case EventType.EVALUATION_POLLING:
          List pollingResult = evaluationMap;

          pollingResult.forEach((element) {
            String flag = (element as EvaluationResponse).flag;
            dynamic value = (element as EvaluationResponse).value;
            parseEvaluationFlag(flag, value);
          });
          break;
      }
    });
  }

  void _display(FeatureType featureType, bool value) {
    features.forEach((element) { if (element.featureType == featureType) { element.setAvailable(value); }});
  }
  void _limit(FeatureType featureType, int value) {
    features.forEach((element) { if (element.featureType == featureType) { element.featureTrialPeriod = value; }});
  }

  void parseEvaluationFlagFromCache(String flag) {
    switch (flag) {
      case "harnessappdemoenableglobalhelp":
      case "harnessappdemoenablecvmodule":
      case "harnessappdemoenablecimodule":
      case "harnessappdemoenablecfmodule":
      case "harnessappdemoenablecemodule":
      case "harnessappdemodarkmode":
      case "harnessappdemocfribbon":
        fetchBooleansFromCache(flag);
        break;
      case "harnessappdemocvtriallimit":
      case "harnessappdemocitriallimit":
      case "harnessappdemocftriallimit":
      case "harnessappdemocetriallimit":
        fetchNumbersFromCache(flag);
        break;
      case "testmultivar_flag":
        break;
      case "test0223":
        break;
      default: break;
    }
  }

  void fetchBooleansFromCache(String flag) {
    switch (flag) {
      case "harnessappdemoenableglobalhelp":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            features.forEach((element) { if (element.featureType == FeatureType.Help) { element.isHelpEnabled = value; }});
          });
        });
        break;
      case "harnessappdemoenablecvmodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            _display(FeatureType.Verification, value);
          });
        });
        break;
      case "harnessappdemoenablecimodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            _display(FeatureType.Integration, value);
          });
        });
        break;
      case "harnessappdemoenablecfmodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            _display(FeatureType.Features, value);
          });
        });
        break;
      case "harnessappdemoenablecemodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            _display(FeatureType.Efficiency, value);
          });
        });
        break;
      case "harnessappdemodarkmode":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            features.forEach((element) { element.setDarkMode(value); });
            _enabledDarkMode = value;
          });
        });
        break;
      case "harnessappdemocfribbon":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            features.forEach((element) { if (element.featureType == FeatureType.Features) { element.setRibbon(value); }});
          });
        });
        break;
    }
  }

  void fetchNumbersFromCache(String flag) {
    switch (flag) {
      case "harnessappdemocvtriallimit":
        CfClient.numberVariation(flag, 0.0).then((value) {
          setState(() {
            _limit(FeatureType.Verification, value.toInt());
          });
        });
        break;
      case "harnessappdemocitriallimit":
        CfClient.numberVariation(flag, 0.0).then((value) {
          setState(() {
            _limit(FeatureType.Integration, value.toInt());
          });
        });
        break;
      case "harnessappdemocftriallimit":
        CfClient.numberVariation(flag, 0.0).then((value) {
          setState(() {
            _limit(FeatureType.Features, value.toInt());
          });
        });
        break;
      case "harnessappdemocetriallimit":
        CfClient.numberVariation(flag, 0.0).then((value) {
          setState(() {
            _limit(FeatureType.Efficiency, value.toInt());
          });
        });
        break;
    }
  }

  void parseEvaluationFlag(String flag, dynamic value) {
    if (value is String) {
      List components = value.split(":");
      if (components.length > 1) {
        //process json
      }
    } else if (value is bool) {
      processBooleans(flag, value);
    } else if (value is int) {
      processNumbers(flag, value);
    } else if (value is double) {
      processNumbers(flag, value.toInt());
    }
  }

  void processBooleans(String flag, bool value) {
    switch (flag) {
      case "harnessappdemoenableglobalhelp":
        setState(() {
          features.forEach((element) { if (element.featureType == FeatureType.Help) { element.isHelpEnabled = value; }});
        });
        break;
      case "harnessappdemoenablecvmodule":
        setState(() {
          _display(FeatureType.Verification, value);
        });
        break;
      case "harnessappdemoenablecimodule":
        setState(() {
          _display(FeatureType.Integration, value);
        });
        break;
      case "harnessappdemoenablecfmodule":
        setState(() {
          _display(FeatureType.Features, value);
        });
        break;
      case "harnessappdemoenablecemodule":
        setState(() {
          _display(FeatureType.Efficiency, value);
        });
        break;
      case "harnessappdemodarkmode":
        setState(() {
          features.forEach((element) { element.setDarkMode(value); });
          _enabledDarkMode = value;
        });
        break;
      case "harnessappdemocfribbon":
        setState(() {
          features.forEach((element) { if (element.featureType == FeatureType.Features) { element.setRibbon(value); }});
        });
        break;
    }
  }

  void processNumbers(String flag, int value) {
    switch (flag) {
      case "harnessappdemocvtriallimit":
        setState(() {
          _limit(FeatureType.Verification, value);
        });
        break;
      case "harnessappdemocitriallimit":
        setState(() {
          _limit(FeatureType.Integration, value);
        });
        break;
      case "harnessappdemocftriallimit":
        setState(() {
          _limit(FeatureType.Features, value);
        });
        break;
      case "harnessappdemocetriallimit":
        setState(() {
          _limit(FeatureType.Efficiency, value);
        });
        break;
    }
  }
}