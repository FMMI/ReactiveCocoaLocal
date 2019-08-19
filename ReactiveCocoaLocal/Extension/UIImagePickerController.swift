//
//  UIImagePickerController.swift
//  MultimediEditing
//
//  Created by snlo on 2019/8/9.
//  Copyright © 2019 snlo. All rights reserved.
//

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



