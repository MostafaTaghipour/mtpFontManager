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

![dynamic types](/screenshots/1.gif)

![system font](/screenshots/2.png)



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
1. Add your custom font to  your project ([you can use this link](https://medium.com/yay-its-erica/how-to-import-fonts-into-xcode-swift-3-f0de7e921ef8))

2. Create new plist file and declare your font for various weights

![font plist file](/screenshots/3.png)

3. Apply your custom font in AppDelegate and pass the name of the plist file created by you

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    //'appFont' is the name of the plist file created by you
    FontManager.setFont(plist: "appFont")

    return true
}
```

4. Use the font in the usual way

    Interface Builder:

    ![use storyboard](/screenshots/4.png)

    Or Programmically:

    ```swift
        label.font=UIFont.preferredFont(forTextStyle: .body)
        label2.font=UIFont.boldSystemFont(ofSize: 17.0)
    ```

5. If you want use dynamic types declare StyleWatcher in your view controller and watch views that use dynamic fonts , like this

```swift
import UIKit
import mtpFontManager

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    let watcher = StyleWatcher()

    override func viewDidLoad() {
        super.viewDidLoad()

        //if you want use dynamic types programmically, you must declare it before watch views
        label.font=UIFont.preferredFont(forTextStyle: .body)

        //whatch view that include the controls that use dynamic types
        watcher.watchViews(inView: view)

        //Or you can just watch spececific control that use dynamic types
        /*
        watcher.watchLabel(label: label)
        watcher.watchButton(label: button)
        watcher.watchTextField(label: textField)
        watcher.watchTextView(label: textView)
        */
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
