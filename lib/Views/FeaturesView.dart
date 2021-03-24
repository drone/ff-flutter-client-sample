import 'package:flutter/material.dart';
import 'dart:ui';
import 'FeatureListItem.dart';
import 'FeatureType.dart';
import 'package:ff_flutter_client_sdk/CfClient.dart';


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

  dynamic requestedValue;

  Map<dynamic, dynamic> _multivar = new Map();


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
          fetchJsonsFromCache(flag);
          break;
        case "test0223":
          fetchStringsFromCache(flag);
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
            features.forEach((element) { if (element.featureType == FeatureType.Verification) { element.setAvailable(value); }});
          });
        });
        break;
      case "harnessappdemoenablecimodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            print("CACHE: CI Module => $value");
            features.forEach((element) { if (element.featureType == FeatureType.Integration) { element.setAvailable(value); }});
          });
        });
        break;
      case "harnessappdemoenablecfmodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            print("CACHE: CF Module => $value");
            features.forEach((element) { if (element.featureType == FeatureType.Features) { element.setAvailable(value); }});
          });
        });
        break;
      case "harnessappdemoenablecemodule":
        CfClient.boolVariation(flag, false).then((value) {
          setState(() {
            print("CACHE: CE Module => $value");
            features.forEach((element) { if (element.featureType == FeatureType.Efficiency) { element.setAvailable(value); }});
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
            int cvTrial = value.toInt();
            setState(() {
              print("CACHE: CV Trial => $value");
            });
          });
          break;
        case "harnessappdemocitriallimit":
          CfClient.numberVariation(flag, 0.0).then((value) {
            int ciTrial = value.toInt();
            setState(() {
              print("CACHE: CI Trial => $value");
            });
          });
          break;
        case "harnessappdemocftriallimit":
          CfClient.numberVariation(flag, 0.0).then((value) {
            int cfTrial = value.toInt();
            setState(() {
              print("CACHE: CF Trial => $value");
            });
          });
          break;
        case "harnessappdemocetriallimit":
          CfClient.numberVariation(flag, 0.0).then((value) {
            int ceTrial = value.toInt();
            setState(() {
              print("CACHE: CE Trial => $value");
            });
          });
          break;
      }
    }

    void fetchJsonsFromCache(String flag) {
      switch (flag) {
        case "testmultivar_flag":
          CfClient.jsonVariation(flag, {"dummyFlag":"dummyValue"}).then((value){
            setState(() {
              _multivar = value;
              requestedValue = value;
              print("CACHE: Multivar => $value");
            });
          });
      }
    }

    void fetchStringsFromCache(String flag) {
      CfClient.stringVariation(flag, "").then((value) {
        setState(() {
          requestedValue = value;
          print("CACHE: Some String => $value");
        });
      });
    }

    void parseEvaluationFlag(String flag, dynamic value) {
      if (value is String) {
        List components = value.split(":");
        if (components.length > 1) {
          String key = components[0];
          dynamic value = components[1];
          processJsons(flag, {key:value});
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
          String globalHelp = (value) ? "ON" : "OFF";
          setState(() {
            features.forEach((element) { if (element.featureType == FeatureType.Help) { element.isHelpEnabled = value; }});
            print("Set Global Help => $value");
          });
          break;
        case "harnessappdemoenablecvmodule":
          String cvModule = (value) ? "ON" : "OFF";
          setState(() {
            print("Set CV Module => $value");
            features.forEach((element) { if (element.featureType == FeatureType.Verification) { element.setAvailable(value); }});
          });
          break;
        case "harnessappdemoenablecimodule":
          String ciModule = (value) ? "ON" : "OFF";
          setState(() {
            print("Set CI Module => $value");
            features.forEach((element) { if (element.featureType == FeatureType.Integration) { element.setAvailable(value); }});
          });
          break;
        case "harnessappdemoenablecfmodule":
          String cfModule = (value) ? "ON" : "OFF";
          setState(() {
            print("Set CF Module => $value");
            features.forEach((element) { if (element.featureType == FeatureType.Features) { element.setAvailable(value); }});
          });
          break;
        case "harnessappdemoenablecemodule":
          String ceModule = (value) ? "ON" : "OFF";
          setState(() {
            print("Set CE Module => $value");
            features.forEach((element) { if (element.featureType == FeatureType.Efficiency) { element.setAvailable(value); }});
          });
          break;
        case "harnessappdemodarkmode":

          String darkMode = (value) ? "ON" : "OFF";
          setState(() {
            print("Set Dark Mode => $value");
            features.forEach((element) { element.setDarkMode(value); });
            _enabledDarkMode = value;
          });
          break;
        case "harnessappdemocfribbon":
          String cfRibbon = (value) ? "ON" : "OFF";
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
            features.forEach((element) { if (element.featureType == FeatureType.Verification) { element.featureTrialPeriod = value; }});
          });
          break;
        case "harnessappdemocitriallimit":
          setState(() {
            print("Set CI Trial => $value");
            features.forEach((element) { if (element.featureType == FeatureType.Integration) { element.featureTrialPeriod = value; }});
          });
          break;
        case "harnessappdemocftriallimit":
          setState(() {
            print("Set CF Trial => $value");
            features.forEach((element) { if (element.featureType == FeatureType.Features) { element.featureTrialPeriod = value; }});
          });
          break;
        case "harnessappdemocetriallimit":
          setState(() {
            features.forEach((element) { if (element.featureType == FeatureType.Efficiency) { element.featureTrialPeriod = value; }});
            print("Set CE Trial => $value");
          });
          break;
      }
    }

    void processJsons(String flag, dynamic value) {
      switch (flag) {
        case "testmultivar_flag":
          setState(() {
            _multivar = value;
            print("Set Multivar => $value");
          });
          break;
      }
    }
  }