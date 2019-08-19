[![CocoaPods compatible](https://img.shields.io/cocoapods/v/ReactiveCocoa.svg)](#cocoapods) [![GitHub release](https://img.shields.io/github/release/ReactiveCocoa/ReactiveCocoa.svg)](https://github.com/ReactiveCocoa/ReactiveCocoa/releases) ![Swift 3.0.x](https://img.shields.io/badge/Swift-5.0.x-orange.svg) ![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20OS%20X%20%7C%20watchOS%20%7C%20tvOS%20-lightgrey.svg)

## What is ReactiveSwift?
__ReactiveSwift__ offers composable, declarative and flexible primitives that are built around the grand concept of ___streams of values over time___. These primitives can be used to uniformly represent common Cocoa and generic programming patterns that are fundamentally an act of observation.

For more information about the core primitives, see [ReactiveSwift][].

## What is ReactiveCocoa?

__ReactiveCocoa__ wraps various aspects of Cocoa frameworks with the declarative [ReactiveSwift][] primitives, It provides a rich extension.UI Bindings \ Controls and User Interactions \ Declarative Objective-C Dynamism \ Expressive, Safe Key Path Observation... ...

See [ReactiveCocoa][] for more information.

## What can ReactiveCocoaKit do?

__ReactiveCocoaKit__  is almost identical to ReactiveCocoa, but ReactiveCocoaKit exposes the dynamic nature of ReactiveCocoa. So it's convenient to provide extensions for other frameworks including agents, not just Cocoa frameworks.
Here's an example of a proxy event extension response for UIImagePickerController:

```swift
import ReactiveSwift
import UIKit

private class ImagePickerControllerDelegateProxy: DelegateProxy<UIImagePickerControllerDelegate> ,UIImagePickerControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        forwardee?.imagePickerController?(picker, didFinishPickingMediaWithInfo: info)
    }
    
}

extension Reactive where Base: UIImagePickerController {
	
    private var proxy: ImagePickerControllerDelegateProxy {
        return .proxy(for: base,
                      setter: #selector(setter: base.delegate),
                      getter: #selector(getter: base.delegate))
    }
    
    public var pickedMedia: Signal<(picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any]), Never> {
        return proxy.intercept(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
            .map { (picker: $0[0] as! UIImagePickerController, info: $0[1] as! [UIImagePickerController.InfoKey : Any]) }
    }
}
```

use：

```swift
let imagePicker = UIImagePickerController.init()
imagePicker.sourceType = .photoLibrary

present(imagePicker, animated: true) {
    imagePicker.reactive.pickedMedia.observe { (event) in
        print(" - - -")
    }
}
```

DelegateProxy is not accessible in ReactiveCocoa

## CocoaPods

If you use [CocoaPods][] to manage your dependencies, simply add
ReactiveCocoa to your `Podfile`:

```
pod 'ReactiveCocoaKit'
```

[ReactiveSwift]: https://github.com/ReactiveCocoa/ReactiveSwift
[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/
[submodule]: https://git-scm.com/book/en/v2/Git-Tools-Submodules
[`Signal`]: https://github.com/ReactiveCocoa/ReactiveSwift/blob/master/Documentation/FrameworkOverview.md#signals
[`SignalProducer`]: https://github.com/ReactiveCocoa/ReactiveSwift/blob/master/Documentation/FrameworkOverview.md#signal-producers
[`Action`]: https://github.com/ReactiveCocoa/ReactiveSwift/blob/master/Documentation/FrameworkOverview.md#actions
[`BindingTarget`]: https://github.com/ReactiveCocoa/ReactiveSwift/blob/master/Documentation/FrameworkOverview.md#properties
