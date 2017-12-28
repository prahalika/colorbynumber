//
//  Pixel.swift
//  ColorByNumber
//
//  Created by Razvan Bangu on 2017-12-28.
//  Copyright © 2017 Prahalika. All rights reserved.
//

import UIKit

struct Pixel {
    var r: UInt8
    var g: UInt8
    var b: UInt8
    var a: UInt8
    var row: Int
    var col: Int

    init(r: UInt8, g: UInt8, b: UInt8, a: UInt8, row: Int, col: Int) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        self.row = row
        self.col = col
    }

    var color: UIColor {
        return UIColor(red: CGFloat(Double(r)/255.0), green: CGFloat(Double(g)/255.0), blue: CGFloat(Double(b)/255.0), alpha: CGFloat(Double(a)/255.0))
    }

    var description: String {
        return "RGBA(\(r), \(g), \(b), \(a))"
    }
}

extension Pixel : Equatable {
    public static func ==(lhs: Pixel, rhs: Pixel) -> Bool {
        return lhs.r == rhs.r && lhs.g == rhs.g && lhs.b == rhs.b && lhs.a == rhs.a
    }
}

extension Pixel : Comparable {
    public static func <(lhs: Pixel, rhs: Pixel) -> Bool {
        return UInt(lhs.hashValue) < UInt(rhs.hashValue)
    }

    public static func >(lhs: Pixel, rhs: Pixel) -> Bool {
        return UInt(lhs.hashValue) > UInt(rhs.hashValue)
    }

    public static func <=(lhs: Pixel, rhs: Pixel) -> Bool {
        return lhs < rhs || lhs == rhs
    }

    public static func >=(lhs: Pixel, rhs: Pixel) -> Bool {
        return lhs > rhs || lhs == rhs
    }
}

extension Pixel : Hashable {
    public var hashValue: Int {
        let redHash = UInt32(self.r) << 24
        let greenHash = UInt32(self.g) << 16
        let blueHash = UInt32(self.b) << 8
        let alphaHash = UInt32(self.a)
        return Int(redHash | greenHash | blueHash | alphaHash)
    }
}

extension UIImage {
    func pixelData() -> [Pixel] {
        guard let bmp = self.cgImage?.dataProvider?.data else {
            print("Error getting pixel data from image")
            return []
        }

        guard var data = CFDataGetBytePtr(bmp) else {
            print("Error getting pixel data from image")
            return []
        }

        var r, g, b, a: UInt8
        var pixels: [Pixel] = []

        for row in 0..<Int(self.size.height) {
            for col in 0..<Int(self.size.width) {
                r = data.pointee
                data = data.advanced(by: 1)
                g = data.pointee
                data = data.advanced(by: 1)
                b = data.pointee
                data = data.advanced(by: 1)
                a = data.pointee
                data = data.advanced(by: 1)
                pixels.append(Pixel(r: r, g: g, b: b, a: a, row: row, col: col))
            }
        }

        return pixels
    }
}
