//
//  Pixel.swift
//  ColorByNumber
//
//  Created by Razvan Bangu on 2017-12-28.
//  Copyright © 2017 Razhalika. All rights reserved.
//

import UIKit

struct Pixel {
    var r, g, b, a: UInt8

    init(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
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
        return UInt32(lhs.hashValue) == UInt32(rhs.hashValue)
    }
}

extension Pixel : Comparable {
    public static func <(lhs: Pixel, rhs: Pixel) -> Bool {
        return UInt32(lhs.hashValue) < UInt32(rhs.hashValue)
    }

    public static func >(lhs: Pixel, rhs: Pixel) -> Bool {
        return UInt32(lhs.hashValue) > UInt32(rhs.hashValue)
    }

    public static func <=(lhs: Pixel, rhs: Pixel) -> Bool {
        return lhs < rhs || lhs == rhs
    }

    public static func >=(lhs: Pixel, rhs: Pixel) -> Bool {
        return lhs > rhs || lhs == rhs
    }
}

extension Pixel : Hashable {
    /// Computes a 32-bit unsigned integer where the bits are divided as follows:
    /// [31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00]
    /// [          red          |         green         |          blue         |         alpha         ]
    /// Each of red, green, blue, and alpha can take values from 0-255, so they fit in 8 bits
    public var hashValue: Int {
        let redBits     = UInt32(r) << (8 * 3)
        let greenBits   = UInt32(g) << (8 * 2)
        let blueBits    = UInt32(b) << (8 * 1)
        let alphaBits   = UInt32(a) << (8 * 0)
        return Int(redBits | greenBits | blueBits | alphaBits)
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

        for _ in 0..<Int(self.size.height)*Int(self.size.width) {
            r = data.pointee
            data = data.advanced(by: 1)
            g = data.pointee
            data = data.advanced(by: 1)
            b = data.pointee
            data = data.advanced(by: 1)
            a = data.pointee
            data = data.advanced(by: 1)
            pixels.append(Pixel(r:r, g:g, b:b, a:a))
        }

        return pixels
    }
}
