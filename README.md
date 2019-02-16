# ☝🏼 React Native Permissions

See the original project for details: https://github.com/yonahforst/react-native-permissions

WARNING: Only use this if all you want is Camera permissions and you are using a package that depends on react-native-permissions.

## API

### Permissions statuses

Promises resolve into one of these statuses:

| Return value   | Notes                                                                                                                                                                                                                                                                  |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `authorized`   | User has authorized this permission                                                                                                                                                                                                                                    |
| `denied`       | User has denied this permission at least once. On iOS this means that the user will not be prompted again. Android users can be prompted multiple times until they select 'Never ask me again'                                                                          |
| `restricted`   | **iOS** - this means user is not able to grant this permission, either because it's not supported by the device or because it has been blocked by parental controls. **Android** - this means that the user has selected 'Never ask me again' while denying permission |
| `undetermined` | User has not yet been prompted with a permission dialog                                                                                                                                                                                                                |

### Supported permissions types

The current supported permissions are:

|                    | Type                | iOS | Android |
| ------------------ | ------------------- | --- | ------- |
| Camera             | `camera`            | ✔️  | ✔       |

### Methods

| Method Name         | Arguments | Notes                                                                                                                                                                                                                                                                            |
| ------------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `check()`           | `type`    | - Returns a promise with the permission status. See iOS Notes for special cases                                                                                                                                                                                                  |
| `request()`         | `type`    | - Accepts any permission type except `backgroundRefresh`. If the current status is `undetermined`, shows the permission dialog and returns a promise with the resulting status. Otherwise, immediately return a promise with the current status. See iOS Notes for special cases |
| `checkMultiple()`   | `[types]` | - Accepts an array of permission types and returns a promise with an object mapping permission types to statuses                                                                                                                                                                 |
| `getTypes()`        | _none_    | - Returns an array of valid permission types                                                                                                                                                                                                                                     |
| `openSettings()`    | _none_    | - _(iOS only - 8.0 and later)_ Switches the user to the settings page of your app                                                                                                                                                                                                |
| `canOpenSettings()` | _none_    | - _(iOS only)_ Returns a boolean indicating if the device supports switching to the settings page                                                                                                                                                                                |
