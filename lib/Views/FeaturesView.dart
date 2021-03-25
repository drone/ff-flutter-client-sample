import 'package:flutter/material.dart';
import 'dart:ui';
import 'FeatureListItem.dart';
import 'FeatureType.dart';
import 'package:ff_flutter_client_sdk/CfClient.dart';


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
          TextButton(onPressed: () { this._destroyTapped(); },
              child: Text('Destroy',
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold))
          )
        ],
      ),
      body: FeaturesGrid(),
    );
  }

  _destroyTapped() {
      CfClient.destroy();
  }
}

class FeaturesGrid extends StatefulWidget {

  FeaturesGrid({Key key}) : super(key: key);

  @override
  _FeaturesGrid createState() => _FeaturesGrid();
}

class _FeaturesGrid extends State<FeaturesGrid> {

  List<FeatureCard> features = [CDModule(),NeedHelp(),CVModule(), CIModule(), CEModule(), CFModule()];

  bool  _enabledDarkMode = false;
  Function _eventListener;


  @override
  Widget build(BuildContext context) {
    return  Container(
      color: _enabledDarkMode ? Colors.black : Colors.white,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        children: List.generate(features.length, (index) {
          return SizedBox(height: double.infinity,
            child: Padding(padding: EdgeInsets.all(0),
              child: FetureListItem(card: features[index])),
          );
        }),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerForEvents();
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
          String key = (evaluationMap as EvaluationResponse).evaluationId;
          dynamic value = (evaluationMap as EvaluationResponse).evaluationValue;
          parseEvaluationFlag(key, value);
          break;
        case EventType.EVALUATION_POLLING:
          List pollingResult = evaluationMap;

          pollingResult.forEach((element) {
            String key = (element as EvaluationResponse).evaluationId;
            dynamic value = (element as EvaluationResponse).evaluationValue;
            parseEvaluationFlag(key, value);
          });
          break;
      }
    });
    parseEvaluationFlagFromCache("harnessappdemoenableglobalhelp");
    parseEvaluationFlagFromCache("harnessappdemodarkmode");
    parseEvaluationFlagFromCache("harnessappdemoenablecvmodule");
    parseEvaluationFlagFromCache("harnessappdemoenablecimodule");
    parseEvaluationFlagFromCache("harnessappdemoenablecfmodule");
    parseEvaluationFlagFromCache("harnessappdemoenablecemodule");
    parseEvaluationFlagFromCache("harnessappdemocfribbon");
    parseEvaluationFlagFromCache("harnessappdemocvtriallimit");
    parseEvaluationFlagFromCache("harnessappdemocitriallimit");
    parseEvaluationFlagFromCache("harnessappdemocftriallimit");
    parseEvaluationFlagFromCache("harnessappdemocetriallimit");
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
            print("CACHE: Global Help => $value");
            features.forEach((element) { if (element.featureType == FeatureType.Help) { element.isHelpEnabled = value; }});
          });
        });
        break;
      case "harnessappdemoenablecvmodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            print("CACHE: CV Module => $value");
            _display(FeatureType.Verification, value);
          });
        });
        break;
      case "harnessappdemoenablecimodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            print("CACHE: CI Module => $value");
            _display(FeatureType.Integration, value);
          });
        });
        break;
      case "harnessappdemoenablecfmodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            print("CACHE: CF Module => $value");
            _display(FeatureType.Features, value);
          });
        });
        break;
      case "harnessappdemoenablecemodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            print("CACHE: CE Module => $value");
            _display(FeatureType.Efficiency, value);
          });
        });
        break;
      case "harnessappdemodarkmode":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            print("CACHE: Dark Mode => $value");
            features.forEach((element) { element.setDarkMode(value); });
            _enabledDarkMode = value;
          });
        });
        break;
      case "harnessappdemocfribbon":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            print("CACHE: CF Ribbon => $value");
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
              print("CACHE: CV Trial => $value");
              _limit(FeatureType.Verification, value.toInt());
            });
          });
          break;
        case "harnessappdemocitriallimit":
          CfClient.numberVariation(flag, 0.0).then((value) {
            setState(() {
              print("CACHE: CI Trial => $value");
              _limit(FeatureType.Integration, value.toInt());
            });
          });
          break;
        case "harnessappdemocftriallimit":
          CfClient.numberVariation(flag, 0.0).then((value) {
            setState(() {
              print("CACHE: CF Trial => $value");
              _limit(FeatureType.Features, value.toInt());
            });
          });
          break;
        case "harnessappdemocetriallimit":
          CfClient.numberVariation(flag, 0.0).then((value) {
            setState(() {
              print("CACHE: CE Trial => $value");
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
        } else {
          processStrings(flag, value);
        }
      } else if (value is bool) {
        processBooleans(flag, value);
      } else if (value is int) {
        processNumbers(flag, value);
      } else if (value is double) {
        processNumbers(flag, value.toInt());
      }
    }

    void processStrings(String flag, String value) {
      setState(() {
        print("Set Some String => $value");
      });
    }

    void processBooleans(String flag, bool value) {
      switch (flag) {
        case "harnessappdemoenableglobalhelp":
          setState(() {
            features.forEach((element) { if (element.featureType == FeatureType.Help) { element.isHelpEnabled = value; }});
            print("Set Global Help => $value");
          });
          break;
        case "harnessappdemoenablecvmodule":
          setState(() {
            print("Set CV Module => $value");
            _display(FeatureType.Verification, value);
          });
          break;
        case "harnessappdemoenablecimodule":
          setState(() {
            print("Set CI Module => $value");
            _display(FeatureType.Integration, value);
          });
          break;
        case "harnessappdemoenablecfmodule":
          setState(() {
            print("Set CF Module => $value");
            _display(FeatureType.Features, value);
          });
          break;
        case "harnessappdemoenablecemodule":
          setState(() {
            print("Set CE Module => $value");
            _display(FeatureType.Efficiency, value);
          });
          break;
        case "harnessappdemodarkmode":
          setState(() {
            print("Set Dark Mode => $value");
            features.forEach((element) { element.setDarkMode(value); });
            _enabledDarkMode = value;
          });
          break;
        case "harnessappdemocfribbon":
          setState(() {
            features.forEach((element) { if (element.featureType == FeatureType.Features) { element.setRibbon(value); }});
            print("Set CF Ribbon => $value");
          });
          break;
      }
    }

    void processNumbers(String flag, int value) {
      switch (flag) {
        case "harnessappdemocvtriallimit":
          setState(() {
            print("Set CV Trial => $value");
            _limit(FeatureType.Verification, value);
          });
          break;
        case "harnessappdemocitriallimit":
          setState(() {
            print("Set CI Trial => $value");
            _limit(FeatureType.Integration, value);
          });
          break;
        case "harnessappdemocftriallimit":
          setState(() {
            print("Set CF Trial => $value");
            _limit(FeatureType.Features, value);
          });
          break;
        case "harnessappdemocetriallimit":
          setState(() {
            _limit(FeatureType.Efficiency, value);
            print("Set CE Trial => $value");
          });
          break;
      }
    }
 }