//
//  GradientStroke.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/8/19.
//

import Foundation

// MARK: - LineCap

enum LineCap: Int, Codable {
    case none
    case butt
    case round
    case square
}

// MARK: - LineJoin

enum LineJoin: Int, Codable {
    case none
    case miter
    case round
    case bevel
}

// MARK: - GradientStroke

/// An item that define an ellipse shape
final class GradientStroke: ShapeItem {
    // MARK: Lifecycle

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GradientStroke.CodingKeys.self)
        opacity = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .opacity)
        startPoint = try container.decode(KeyframeGroup<Vector3D>.self, forKey: .startPoint)
        endPoint = try container.decode(KeyframeGroup<Vector3D>.self, forKey: .endPoint)
        gradientType = try container.decode(GradientType.self, forKey: .gradientType)
        highlightLength = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .highlightLength)
        highlightAngle = try container.decodeIfPresent(KeyframeGroup<Vector1D>.self, forKey: .highlightAngle)
        width = try container.decode(KeyframeGroup<Vector1D>.self, forKey: .width)
        lineCap = try container.decodeIfPresent(LineCap.self, forKey: .lineCap) ?? .round
        lineJoin = try container.decodeIfPresent(LineJoin.self, forKey: .lineJoin) ?? .round
        miterLimit = try container.decodeIfPresent(Double.self, forKey: .miterLimit) ?? 4
        // TODO: Decode Color Objects instead of array.
        let colorsContainer = try container.nestedContainer(keyedBy: GradientDataKeys.self, forKey: .colors)
        colors = try colorsContainer.decode(KeyframeGroup<[Double]>.self, forKey: .colors)
        numberOfColors = try colorsContainer.decode(Int.self, forKey: .numberOfColors)
        dashPattern = try container.decodeIfPresent([DashElement].self, forKey: .dashPattern)
        try super.init(from: decoder)
    }

    // MARK: Internal

    /// The opacity of the fill
    let opacity: KeyframeGroup<Vector1D>

    /// The start of the gradient
    let startPoint: KeyframeGroup<Vector3D>

    /// The end of the gradient
    let endPoint: KeyframeGroup<Vector3D>

    /// The type of gradient
    let gradientType: GradientType

    /// Gradient Highlight Length. Only if type is Radial
    let highlightLength: KeyframeGroup<Vector1D>?

    /// Highlight Angle. Only if type is Radial
    let highlightAngle: KeyframeGroup<Vector1D>?

    /// The number of color points in the gradient
    let numberOfColors: Int

    /// The Colors of the gradient.
    let colors: KeyframeGroup<[Double]>

    /// The width of the stroke
    let width: KeyframeGroup<Vector1D>

    /// Line Cap
    let lineCap: LineCap

    /// Line Join
    let lineJoin: LineJoin

    /// Miter Limit
    let miterLimit: Double

    /// The dash pattern of the stroke
    let dashPattern: [DashElement]?

    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(opacity, forKey: .opacity)
        try container.encode(startPoint, forKey: .startPoint)
        try container.encode(endPoint, forKey: .endPoint)
        try container.encode(gradientType, forKey: .gradientType)
        try container.encodeIfPresent(highlightLength, forKey: .highlightLength)
        try container.encodeIfPresent(highlightAngle, forKey: .highlightAngle)
        try container.encode(width, forKey: .width)
        try container.encode(lineCap, forKey: .lineCap)
        try container.encode(lineJoin, forKey: .lineJoin)
        try container.encode(miterLimit, forKey: .miterLimit)
        var colorsContainer = container.nestedContainer(keyedBy: GradientDataKeys.self, forKey: .colors)
        try colorsContainer.encode(numberOfColors, forKey: .numberOfColors)
        try colorsContainer.encode(colors, forKey: .colors)
        try container.encodeIfPresent(dashPattern, forKey: .dashPattern)
    }

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
        case opacity = "o"
        case startPoint = "s"
        case endPoint = "e"
        case gradientType = "t"
        case highlightLength = "h"
        case highlightAngle = "a"
        case colors = "g"
        case width = "w"
        case lineCap = "lc"
        case lineJoin = "lj"
        case miterLimit = "ml"
        case dashPattern = "d"
    }

    private enum GradientDataKeys: String, CodingKey {
        case numberOfColors = "p"
        case colors = "k"
    }
}
