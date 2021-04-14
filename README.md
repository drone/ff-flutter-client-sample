# Example App using Harness Flutter SDK (ff-flutter-client-sdk) for Demo purposes

This Demo App will demonstrate the usage and capabilities of Flutter client SDK.

### Setup
To install SDK, add a dependency to project's `pubspec.yaml` file:
```Dart
ff_flutter_client_sdk: ^0.0.1
```

Then, you may import package to your project
```Dart
import 'package:ff_flutter_client_sdk/CfClient.dart';
```


### Accounts used:
| No. | Account |
| ---- | ---------- |
| 1 | `Aptiv` |
| 2 | `Experian` |
| 3 | `Fiserv` |
| 4 | `Harness` |
| 5 | `Palo Alto Networks` |


During initialization, the target is one of the above accounts, selected from the list, on the first screen of the Demo App.

 In order to change the account, you would need to go back to the initial screen and select a different account to use.