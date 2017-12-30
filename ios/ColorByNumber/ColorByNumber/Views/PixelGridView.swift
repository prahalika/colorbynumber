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

    public var pixelSelected = -1 {
        didSet {
            let selectedPixel = self.uniquePixels[pixelSelected]

            // First clear all of them
            for labels in self.pixelsToLabels.values {
                for label in labels {
                    label.backgroundColor = UIColor.clear
                }
            }

            // Then highlight the selected ones
            for label in self.pixelsToLabels[selectedPixel]! {
                label.backgroundColor = UIColor.lightGray
            }
        }
    }

    private var pixels: [Pixel] = []
    private var uniquePixels: [Pixel] = []
    public var uniquePixelCount: Int {
        get {
            return self.uniquePixels.count
        }
    }

    private var pixelsToLabels: Dictionary <Pixel, [UILabel]> = Dictionary <Pixel, [UILabel]> ()

    public func setup(with image: UIImage!) {
        self.pixels = image.pixelData()
        self.uniquePixels = Set<Pixel>(pixels).sorted()

        let originX = Int(self.frame.size.width / 2 - (image.size.width * 50.0) / 2)
        let originY = Int(self.frame.size.height / 2 - (image.size.height * 50.0) / 2)

        for i in 0..<Int(image.size.width) {
            for j in 0..<Int(image.size.height) {
                let thePixel = self.pixels[i * Int(image.size.width) + j]

                let label = UILabel(frame: CGRect(x: 50 * i + originX, y: 50 * j + originY, width: 50, height: 50))
                label.text = String(describing: self.uniquePixels.index(of: thePixel)! + 1)
                label.textAlignment = .center

                // Create the borders
                var borders = [UIView]()

                borders.append(UIView(frame: CGRect(x: 0, y: 0, width: label.frame.size.width, height: 1))) // Top
                borders.append(UIView(frame: CGRect(x: 0, y: 0, width: 1, height: label.frame.size.height))) // Left
                if j == Int(image.size.height) - 1 {
                    // Bottom
                    borders.append(UIView(frame: CGRect(x: 0, y: label.frame.size.height - 1, width: label.frame.size.width, height: 1)))
                }
                if i == Int(image.size.width) - 1{
                    // Right
                    borders.append(UIView(frame: CGRect(x: label.frame.size.width - 1, y: 0, width: 1, height: label.frame.size.height)))
                }

                for b in borders {
                    b.backgroundColor = UIColor.black
                    label.addSubview(b)
                }

                self.addSubview(label)

                // Maintain our pixels -> labels map
                if var arr = self.pixelsToLabels[thePixel] {
                    arr.append(label)
                    self.pixelsToLabels[thePixel] = arr
                } else {
                    self.pixelsToLabels[thePixel] = [label]
                }
            }

            self.pixelSelected = 0
        }
    }
}
