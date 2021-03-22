import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:ff_flutter_client_sdk/CfClient.dart';

import 'Views/HomePage.dart';

void main() {
  runApp(App());
}


class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'CF mobile SDK Demo'),
    );
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _darkModeOn = "OFF";
  String _cfRibbon = "OFF";
  String _cvModule = "OFF";
  String _ciModule = "OFF";
  String _cfModule = "OFF";
  String _ceModule = "OFF";
  String _globalHelp = "OFF";

  int _cvTrial = 0;
  int _ciTrial = 0;
  int _cfTrial = 0;
  int _ceTrial = 0;

  Map<dynamic, dynamic> _multivar = new Map();

  String _someString = "SOME";

  bool _initialize = false;
  String requestedFlag = "";
  dynamic requestedValue;

  void sendMessage2(String flag) {
    var target = CfTargetBuilder().build();
    target.identifier = "Harness";
    requestedFlag = flag;
    parseEvaluationFlagFromCache(flag);
  }

  void sendMessage() {
    try {
      final String apiKey = "5d59cb10-66cb-405b-ab54-b4d48132f383";
      var conf = CfConfigurationBuilder()
          .setStreamEnabled(false)
          .setPollingInterval(20)
          .build();
      var target = CfTargetBuilder().setIdentifier("Harness").build();

      CfClient.initialize(apiKey, conf, target).then((value) {
        print('received response');
        bool initialized = (value.success);
        setState(() {
          _initialize = initialized;
        });
      }).whenComplete(() => CfClient.registerEventsListener((evaluationMap, eventType) {
        switch (eventType) {
          case EventType.START: 
            print("Started SSE"); 
            break;
          case EventType.END: 
            print("SSE Completed"); 
            break;
          case EventType.EVALUATION_CHANGE:
            String key = Map<String, dynamic>.of(evaluationMap).keys.first;
            dynamic value = Map<String, dynamic>.of(evaluationMap).values.first;      
            parseEvaluationFlag(key, value);
            break;
          case EventType.EVALUATION_POLLING:
            List pollingResult = evaluationMap;
            
            pollingResult.forEach((element) { 
              String key = element["evaluationId"];
              dynamic value = element["evaluationValue"];
              parseEvaluationFlag(key, value);
            });
            break;
        }
        
          }));

    } on PlatformException {}
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
        String globalHelp = (value) ? "ON" : "OFF";
          setState(() {
            _globalHelp = globalHelp;
            requestedValue = value.toString();
            print("CACHE: Global Help => $value");
          });
      }); 
      break;
      case "harnessappdemoenablecvmodule":
      CfClient.boolVariation(flag, false).then((value) {
        String cvModule = (value) ? "ON" : "OFF";
          setState(() {
            _cvModule = cvModule;
            requestedValue = value.toString();
            print("CACHE: CV Module => $value");
          });
      }); 
      break;
      case "harnessappdemoenablecimodule":
      CfClient.boolVariation(flag, false).then((value) {
        String ciModule = (value) ? "ON" : "OFF";
          setState(() {
            _ciModule = ciModule;
            requestedValue = value.toString();
            print("CACHE: CI Module => $value");
          });
      }); 
      break;
      case "harnessappdemoenablecfmodule":
      CfClient.boolVariation(flag, false).then((value) {
        String cfModule = (value) ? "ON" : "OFF";
          setState(() {
            _cfModule = cfModule;
            requestedValue = value.toString();
            print("CACHE: CF Module => $value");
          });
      }); 
      break;
      case "harnessappdemoenablecemodule":
      CfClient.boolVariation(flag, false).then((value) {
        String ceModule = (value) ? "ON" : "OFF";
          setState(() {
            _ceModule = ceModule;
            requestedValue = value.toString();
            print("CACHE: CE Module => $value");
          });
      }); 
      break;
      case "harnessappdemodarkmode":
      CfClient.boolVariation(flag, false).then((value) {
        String darkMode = (value) ? "ON" : "OFF";
          setState(() {
            _darkModeOn = darkMode;
            requestedValue = value.toString();
            print("CACHE: Dark Mode => $value");
          });
      });
      break;
      case "harnessappdemocfribbon":
      CfClient.boolVariation(flag, false).then((value) {
        String cfRibbon = (value) ? "ON" : "OFF";
          setState(() {
            _cfRibbon = cfRibbon;
            requestedValue = value.toString();
            print("CACHE: CF Ribbon => $value");
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
                _cvTrial = cvTrial;
                requestedValue = cvTrial;
                print("CACHE: CV Trial => $value");
              });
          }); 
          break;
          case "harnessappdemocitriallimit":
          CfClient.numberVariation(flag, 0.0).then((value) {
            int ciTrial = value.toInt();
              setState(() {
                _ciTrial = ciTrial;
                requestedValue = ciTrial;
                print("CACHE: CI Trial => $value");
              });
          }); 
          break;
          case "harnessappdemocftriallimit":
          CfClient.numberVariation(flag, 0.0).then((value) {
            int cfTrial = value.toInt();
              setState(() {
                _cfTrial = cfTrial;
                requestedValue = cfTrial;
                print("CACHE: CF Trial => $value");
              });
          }); 
          break;
          case "harnessappdemocetriallimit":
          CfClient.numberVariation(flag, 0.0).then((value) {
            int ceTrial = value.toInt();
              setState(() {
                _ceTrial = ceTrial;
                requestedValue = ceTrial;
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
        _someString = value;
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
    } 
  }

  void processStrings(String flag, String value) {
      setState(() {
        _someString = value;
        print("Set Some String => $value");
      });
  }

  void processBooleans(String flag, bool value) {
    switch (flag) {
      case "harnessappdemoenableglobalhelp":
          String globalHelp = (value) ? "ON" : "OFF";
          setState(() {
            _globalHelp = globalHelp;
            print("Set Global Help => $value");
          });
        break;
      case "harnessappdemoenablecvmodule":
          String cvModule = (value) ? "ON" : "OFF";
          setState(() {
            _cvModule = cvModule;
            print("Set CV Module => $value");
          });
        break;
      case "harnessappdemoenablecimodule":
          String ciModule = (value) ? "ON" : "OFF";
          setState(() {
            _ciModule = ciModule;
            print("Set CI Module => $value");
          });
        break;
      case "harnessappdemoenablecfmodule":
          String cfModule = (value) ? "ON" : "OFF";
          setState(() {
            _cfModule = cfModule;
            print("Set CF Module => $value");
          });
        break;
      case "harnessappdemoenablecemodule":
          String ceModule = (value) ? "ON" : "OFF";
          setState(() {
            _ceModule = ceModule;
            print("Set CE Module => $value");
          });
        break;
      case "harnessappdemodarkmode":

          String darkMode = (value) ? "ON" : "OFF";
          setState(() {
            _darkModeOn = darkMode;
            print("Set Dark Mode => $value");
          });
        break;
      case "harnessappdemocfribbon":
          String cfRibbon = (value) ? "ON" : "OFF";
          setState(() {
            _cfRibbon = cfRibbon;
            print("Set CF Ribbon => $value");
          });
        break;
    }
  }

  void processNumbers(String flag, int value) {
    switch (flag) {
      case "harnessappdemocvtriallimit":
          setState(() {
            _cvTrial = value;
            print("Set CV Trial => $value");
          });
        break;
      case "harnessappdemocitriallimit":
          setState(() {
            _ciTrial = value;
            print("Set CI Trial => $value");
          });
        break;
      case "harnessappdemocftriallimit":
          setState(() {
            _cfTrial = value;
            print("Set CF Trial => $value");
          });
        break;
      case "harnessappdemocetriallimit":
          setState(() {
            _ceTrial = value;
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

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    String success = _initialize ? "Success" : "Failed";
    String typeDropdown = "Choose Flag";
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
          children: [
            Row(children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => sendMessage(),
                        child: Text("Initialize"))),
              ]),
              Divider(),
                Center(child: 
                  Text('Initialization: $success',
                    style: TextStyle(
                    color: _initialize ? Colors.green : Colors.red),
                  )
                ),
              Divider(),
              DropdownButton<String>(
                  value: typeDropdown,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      requestedValue = "";
                      typeDropdown = newValue;
                      requestedFlag = newValue;
                    });
                  },
                  items: [
                    "Choose Flag",
                    "harnessappdemoenableglobalhelp",
                    "harnessappdemoenablecvmodule",
                    "harnessappdemoenablecimodule",
                    "harnessappdemoenablecfmodule",
                    "harnessappdemoenablecemodule",
                    "harnessappdemodarkmode",
                    "harnessappdemocfribbon",
                    "harnessappdemocvtriallimit",
                    "harnessappdemocitriallimit",
                    "harnessappdemocftriallimit",
                    "harnessappdemocetriallimit",
                    "testmultivar_flag"]
                    .map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList()
              ),
             Row(children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => sendMessage2(requestedFlag),
                        child: Text("Get from cache"))),
              ]),
            Text("$requestedFlag => $requestedValue", style: TextStyle(color: Colors.blue),),
            Container(
              height: 500,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('Dark Mode $_darkModeOn')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('CF Ribbon $_cfRibbon')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('CV Module $_cvModule')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('CI Module $_ciModule')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('CF Module $_cfModule')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('CE Module $_ceModule')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('Global Help $_globalHelp')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('CV Trial $_cvTrial')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('CI Trial $_ciTrial')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('CF Trial $_cfTrial')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('CE Trial $_ceTrial')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('Multivar $_multivar')
                    ),
                    Divider(),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Text('Some String $_someString')
                    )
                ],
            )  ,
            )
          ])
        )
      )
    );
  }
}
