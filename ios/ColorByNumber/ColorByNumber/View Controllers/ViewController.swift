//
//  ViewController.swift
//  ColorByNumber
//
//  Created by Razvan Bangu on 2017-12-27.
//  Copyright © 2017 Razhalika. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollviewContentView: UIView!
    @IBOutlet weak var imageContainer: PixelGridView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.minimumZoomScale = 1.0;
        self.scrollView.maximumZoomScale = 6.0;

        let image = #imageLiteral(resourceName: "test_img")

        self.imageContainer.setup(with: image)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.scrollviewContentView
    }

}

