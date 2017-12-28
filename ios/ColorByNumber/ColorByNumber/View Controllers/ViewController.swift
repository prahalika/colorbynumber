//
//  ViewController.swift
//  ColorByNumber
//
//  Created by Razvan Bangu on 2017-12-27.
//  Copyright © 2017 Razhalika. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = #imageLiteral(resourceName: "test_img")

        let pixels = image.pixelData()
        let uniquePixels = Set<Pixel>(pixels)

        print("There are \(uniquePixels.count) unique colors in this image")
    }

}

