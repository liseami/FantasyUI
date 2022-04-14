//
//  CMYK.swift
//  ColorKit
//
//  Created by Boris Emorine on 6/20/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

public extension UIColor {
    /// The cyan (C) channel of the CMYK color space.
    var cyan: CGFloat {
        return (1 - red - key) / (1 - key)
    }

    /// The magenta (M) channel of the CMYK color space.
    var magenta: CGFloat {
        return (1 - green - key) / (1 - key)
    }

    /// The yellow (Y) channel of the CMYK color space.
    var yellow: CGFloat {
        return (1 - blue - key) / (1 - key)
    }

    /// The key (black) (K) channel of the CMYK color space.
    var key: CGFloat {
        return 1 - max(red, green, blue)
    }
}
