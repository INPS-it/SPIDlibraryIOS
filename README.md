# SPIDlibraryIOS

SPIDlibraryIOS is a library for logging in via SPID through several different identity providers.

## Requirements

- iOS 11.0+ 
- Xcode 11+
- Swift 4+


## Usage
1. Add the following to your Package.swift:
```swift
.package(url: "https://github.com/INPS-it/SPIDlibraryIOS", .upToNextMajor(from: "1.0.4"))
```
2. Declare `import SPIDlibraryIOS` in your ViewController.

3. Implement the `SpidDelegate` protocol:
```swift
public class ViewController: UIViewController, SpidDelegate {

    func loginSuccess(response: SpidResponse) {
        print("Login Success")
    }
    
    func onError(error: SpidError) {
        print("Error")
    }
}
```

4. Create a `SpidConfig` object containing the `authPageUrl` url, the `callbackPageUrl` url, the `spidPageInfoUrl` url, the `requestSpidPageUrl` url, an optional timeout `int` value (default value: 30sec), the `identityProviderKeys` object that contains the identity providers keys and the `queryStringParams` string:
```swift
 let identityProviderKeys = IdentityProviderKeys.init(aruba: Constants.IdentityProvider.aruba,
                                                             infocert: Constants.IdentityProvider.infocert,
                                                             intesa: Constants.IdentityProvider.intesa,
                                                             lepida: Constants.IdentityProvider.lepida,
                                                             namirial: Constants.IdentityProvider.namirial,
                                                             poste: Constants.IdentityProvider.poste,
                                                             sielte: Constants.IdentityProvider.sielte,
                                                             spiditalia: Constants.IdentityProvider.spiditalia,
                                                             teamsystem: Constants.IdentityProvider.teamsystem,
                                                             tim: Constants.IdentityProvider.tim)
        
let spidConfig = SpidConfig.init(authPageUrl: Constants.authPageUrl, callbackPageUrl: Constants.callbackPageUrl, spidPageInfoUrl: Constants.spidPageInfoUrl, requestSpidPageUrl: Constants.requestSpidPageUrl, identityProviderKeys: identityProviderKeys, queryStringParams: Constants.queryStringParams)
```
5. Present the `SpidViewController` instance:

```swift
SpidViewController.present(delegate: self, spidConfig: spidConfig)
```

## License

SPIDlibraryIOS is released under the BSD 3-Clause License [See LICENSE](https://github.com/INPS-it/SPIDlibraryIOS/blob/main/LICENSE) for details.
