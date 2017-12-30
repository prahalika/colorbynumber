//
//  PixelGridView.swift
//  ColorByNumber
//
//  Created by Razvan Bangu on 2017-12-29.
//  Copyright © 2017 Razhalika. All rights reserved.
//

import Foundation
import UIKit

class PixelGridView : UIView {

    public var pixelSelected = -1

    private var pixels: [Pixel] = []
    private var uniquePixels: [Pixel] = []
    public var uniquePixelCount: Int {
        get {
            return self.uniquePixels.count
        }
    }

    public func setup(with image: UIImage!) {
        self.pixelSelected = 0
        self.pixels = image.pixelData()
        self.uniquePixels = Set<Pixel>(pixels).sorted()

        let originX = Int(self.frame.size.width / 2 - (image.size.width * 50.0) / 2)
        let originY = Int(self.frame.size.height / 2 - (image.size.height * 50.0) / 2)

        for i in 0..<Int(image.size.width) {
            for j in 0..<Int(image.size.height) {
                let label = UILabel(frame: CGRect(x: 50 * i + originX, y: 50 * j + originY, width: 50, height: 50))
                label.text = String(describing: self.uniquePixels.index(of: self.pixels[i * Int(image.size.width) + j])! + 1)
                label.textAlignment = .center
                label.backgroundColor = UIColor.cyan
                self.addSubview(label)
            }
        }
    }
}
