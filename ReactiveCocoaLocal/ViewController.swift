//
//  ViewController.swift
//  ReactiveCocoaLocal
//
//  Created by snlo on 2019/8/19.
//  Copyright © 2019 snlo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let imagePicker = UIImagePickerController.init()
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true) {
            imagePicker.reactive.pickedMedia.observe { (event) in
                print(" - - -")
            }
        }
        
    }

}

