//
//  RoundedCorners.swift
//  VaporWebSocketClient
//
//  Created by kazunori.aoki on 2023/07/11.
//

import SwiftUI

struct RoundedCorners: View {

    enum `Type` {
        case system
        case user
        case all(color: Color)
        case other(param: Param)
    }

    struct Param {
        var color: Color = .blue
        var tl: CGFloat = 0.0
        var tr: CGFloat = 0.0
        var bl: CGFloat = 0.0
        var br: CGFloat = 0.0
    }

    var type: `Type`

    private let radius: CGFloat = 20

    var body: some View {
        switch type {
        case .system:
            BaseRoundedCorners(color: .white, tl: radius, tr: radius, bl: 0, br: radius)
        case .user:
            BaseRoundedCorners(color: .userMessageBackground, tl: radius, tr: radius, bl: radius, br: 0)
        case .all(let color):
            BaseRoundedCorners(color: color, tl: radius, tr: radius, bl: radius, br: radius)
        case .other(let p):
            BaseRoundedCorners(color: p.color, tl: p.tl, tr: p.tr, bl: p.bl, br: p.br)
        }
    }
}

private struct BaseRoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let w: CGFloat = geometry.size.width
                let h: CGFloat = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr: CGFloat = min(min(self.tr, h/2), w/2)
                let tl: CGFloat = min(min(self.tl, h/2), w/2)
                let bl: CGFloat = min(min(self.bl, h/2), w/2)
                let br: CGFloat = min(min(self.br, h/2), w/2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))

                path.addLine(to: CGPoint(x: w - tr, y: 0))

                path.addArc(center: CGPoint(x: w - tr, y: tr),
                            radius: tr,
                            startAngle: Angle(degrees: -90),
                            endAngle: Angle(degrees: 0),
                            clockwise: false)

                path.addLine(to: CGPoint(x: w, y: h - br))

                path.addArc(center: CGPoint(x: w - br, y: h - br),
                            radius: br,
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 90),
                            clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))

                path.addArc(center: CGPoint(x: bl, y: h - bl),
                            radius: bl,
                            startAngle: Angle(degrees: 90),
                            endAngle:
                                Angle(degrees: 180),
                            clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))

                path.addArc(center: CGPoint(x: tl, y: tl),
                            radius: tl,
                            startAngle: Angle(degrees: 180),
                            endAngle:
                                Angle(degrees: 270),
                            clockwise: false)
            }
            .fill(color)
        }
    }
}
