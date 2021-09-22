# Before you Begin
Harness Feature Flags (FF) is a feature management solution that enables users to change the software’s functionality, without deploying new code. FF uses feature flags to hide code or behaviours without having to ship new versions of the software. A feature flag is like a powerful if statement.

For more information, see https://harness.io/products/feature-flags/

To read more, see https://ngdocs.harness.io/category/vjolt35atg-feature-flags

To sign up, https://app.harness.io/auth/#/signup/


# Example App using Harness Flutter SDK (ff-flutter-client-sdk) for Demo purposes

This Demo App will demonstrate the usage and capabilities of Flutter client SDK.

### Setup
To install SDK, add a dependency to project's `pubspec.yaml` file:

```
ff_flutter_client_sdk: ^1.0.1
```

Then, you may import package to your project

```Dart
import 'package:ff_flutter_client_sdk/CfClient.dart';
```

To be able to run sample app it is required to update `HomePage.dart` with your API key:
```Dart
class _HomePageState extends State<HomePage> {

    static const String apiKey = "YOUR_API_KEY";
    
    // ...
}
```

`"YOUR_API_KEY"` is a authentication key, needed for access to Harness services.

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
