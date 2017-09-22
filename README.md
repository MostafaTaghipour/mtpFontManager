# mtpFontManager

[![CI Status](http://img.shields.io/travis/mostafa.taghipour@ymail.com/mtpFontManager.svg?style=flat)](https://travis-ci.org/mostafa.taghipour@ymail.com/mtpFontManager)
[![Version](https://img.shields.io/cocoapods/v/mtpFontManager.svg?style=flat)](http://cocoapods.org/pods/mtpFontManager)
[![License](https://img.shields.io/cocoapods/l/mtpFontManager.svg?style=flat)](http://cocoapods.org/pods/mtpFontManager)
[![Platform](https://img.shields.io/cocoapods/p/mtpFontManager.svg?style=flat)](http://cocoapods.org/pods/mtpFontManager)



mtpFontManger is a font manager for iOS:

- Support custom fonts
- Applay to entire project
- Interface builder compatible
- Supports various styles
- Supports dynamic types styles

![dynamic types](/3.gif)

<img src="/Simulator%20Screen%20Shot%20Sep%2020%2C%202017%2C%2010.39.54%20PM.png" width="400">



## Requirements
- iOS 8.2+
- Xcode 9+

## Installation

mtpFontManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'mtpFontManager'
```

## Usage
1.Add your custom font to  your project ([you can use this link](https://medium.com/yay-its-erica/how-to-import-fonts-into-xcode-swift-3-f0de7e921ef8))

2.Create new plist file and declare your font for various weights

![font plist file](https://raw.githubusercontent.com/MostafaTaghipour/mtpFontManager/master/Screen%20Shot%202017-09-22%20at%2011.24.15%20PM.png)

3.Apply your custom font in AppDelegate and pass the name of the plist file created by you

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

//'appFont' is the name of the plist file created by you
FontManager.setFont(plist: "appFont")

return true
}
```

5.If you want use dynamic types declare StyleWatcher in your view controller and watch views that use dynamic fonts , like this

```swift
import UIKit
import mtpFontManager

class ViewController: UIViewController {
@IBOutlet weak var label: UILabel!

let watcher = StyleWatcher()

override func viewDidLoad() {
super.viewDidLoad()
// Do any additional setup after loading the view, typically from a nib.

label.font=UIFont.preferredFont(forTextStyle: .body)

watcher.watchViews(inView: view)
}
}
```

Enjoy it



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Inspiration
This project is heavily inspired by [Gliphy](https://github.com/Tallwave/Gliphy).
Kudos to [@Tallwave](https://github.com/Tallwave). :thumbsup:

## Author

Mostafa Taghipour, mostafa.taghipour@ymail.com

## License

mtpFontManager is available under the MIT license. See the LICENSE file for more info.

