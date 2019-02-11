# mtpFontManager

[![CI Status](http://img.shields.io/travis/mostafa.taghipour@ymail.com/mtpFontManager.svg?style=flat)](https://travis-ci.org/mostafa.taghipour@ymail.com/mtpFontManager)
[![Version](https://img.shields.io/cocoapods/v/mtpFontManager.svg?style=flat)](http://cocoapods.org/pods/mtpFontManager)
[![License](https://img.shields.io/cocoapods/l/mtpFontManager.svg?style=flat)](http://cocoapods.org/pods/mtpFontManager)
[![Platform](https://img.shields.io/cocoapods/p/mtpFontManager.svg?style=flat)](http://cocoapods.org/pods/mtpFontManager)


## [Android version is here](https://github.com/MostafaTaghipour/FontManager)

mtpFontManger is a font manager for iOS:

- Support custom fonts
- Apply to entire app
- Support Multiple fonts
- Change font at runtime
- Interface builder compatible
- Supports various styles and weights
- Supports dynamic types 


![custom font app](/screenshots/1.gif)



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

1. Add your custom fonts to your project

![fonts](/screenshots/2.png)

2. Register your fonts 

    #### method1 : Register in Info.plist
    After adding the font file to your project, you need to let iOS know about the font. To do this, add the key "Fonts provided by application" to Info.plist (the raw key name is UIAppFonts). Xcode creates an array value for the key; add the name of the font file as an item of the array. Be sure to include the file extension as part of the name.
    ![plist](/screenshots/4.png)


    #### method2 : Programmatically load custom fonts
    To this use [FontBlaster library](https://github.com/ArtSabintsev/FontBlaster)

    first add FontBlaster library: 
    
```ruby
pod 'FontBlaster'
```

    then load fonts added to the project using the following code:
    
```swift
FontBlaster.blast()
```

3. Declare your fonts
```swift
lazy var exo: AppFont = {
    let font = AppFont(
        id: 1,
        familyName: "Exo",
        defaultFont: "Exo-Regular",
        ultraLight: "Exo-Thin",
        thin: "Exo-ExtraLight",
        light: "Exo-Light",
        regular: "Exo-Regular",
        medium: "Exo-Medium",
        semibold: "Exo-Semibold",
        bold: "Exo-Bold",
        heavy: "Exo-ExtraBold",
        black: "Exo-Black"
    )
    return font
}()
```                            

    #### declare fonts in plist file
    
        Create new plist file and declare your font for various weights:
        ![plist](/screenshots/3.png)

        then use AppFont plist constructor:
        
```swift
    lazy var taviraj: AppFont = {
        let font = AppFont(plist: "taviraj")
        return font
    }()
```

4. Use the font in the usual way

    Interface Builder:
    ![use storyboard](/screenshots/5.png)

    Or Programmically:
```swift
label.font=UIFont.preferredFont(forTextStyle: .body)
label2.font=UIFont.boldSystemFont(ofSize: 17.0)
```
### Dynamic Types
If you want use dynamic types declare StyleWatcher in your view controller and watch views that use dynamic fonts , like this

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

5. Any time you need to change the font of the application use the following code
```swift
FontManager.shared.currentFont = taviraj /* your desired font */
```

6. Thats it, enjoy it

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Inspiration
This project is heavily inspired by [Gliphy](https://github.com/Tallwave/Gliphy).
Kudos to [@Tallwave](https://github.com/Tallwave). :thumbsup:

## Author

Mostafa Taghipour, mostafa@taghipour.me

## License

mtpFontManager is available under the MIT license. See the LICENSE file for more info.
