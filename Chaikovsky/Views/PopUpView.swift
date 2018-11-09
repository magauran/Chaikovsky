//
//  PopUpView.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class PopUpView: UIView {

    private let radius: CGFloat = 8
    private let arrowRadius: CGFloat = 4
    private let arrowWidth: CGFloat = 24
    private let arrowHeight: CGFloat = 18

    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawPopUp(width: rect.width, height: rect.height)
    }

    func configure(with text: String) {
        let label = UILabel(frame: frame)
        label.text = text
        addSubview(label)
    }

    // MARK: - Private methods

    private func drawPopUp(width: CGFloat, height: CGFloat) {
        let startingPoint = CGPoint(x: radius, y: 0)
        let upperRightCenter = CGPoint(x: width - radius, y: radius)
        let bottomRightCenter = CGPoint(x: width - radius, y: height - radius - arrowHeight)
        let bottomLeftCenter = CGPoint(x: radius, y: height - radius - arrowHeight)
        let upperLeftCenter = CGPoint(x: radius, y: radius)

        let path: UIBezierPath = UIBezierPath()

        path.move(to: startingPoint)

        path.addArc(withCenter: upperRightCenter, radius: radius, startAngle: deg2rad(270), endAngle: 0, clockwise: true)

        path.addArc(withCenter: bottomRightCenter, radius: radius, startAngle: 0, endAngle: deg2rad(90), clockwise: true)

        path.addArc(withCenter: CGPoint(x: (width + arrowWidth)/2 + arrowRadius, y: height + arrowRadius - arrowHeight), radius: arrowRadius, startAngle: deg2rad(270), endAngle: deg2rad(225), clockwise: false)

        path.addArc(withCenter: CGPoint(x: width / 2, y: height - arrowRadius), radius: arrowRadius, startAngle: deg2rad(45), endAngle: deg2rad(135), clockwise: true)

        path.addArc(withCenter: CGPoint(x: (width - arrowWidth)/2 - arrowRadius, y: height + arrowRadius - arrowHeight), radius: arrowRadius, startAngle: deg2rad(315), endAngle: deg2rad(270), clockwise: false)

        path.addArc(withCenter: bottomLeftCenter, radius: radius, startAngle: deg2rad(90), endAngle: deg2rad(180), clockwise: true)

        path.addArc(withCenter: upperLeftCenter, radius: radius, startAngle: deg2rad(180), endAngle: deg2rad(270), clockwise: true)

        path.close()

        UIColor.white.setFill()
        UIColor.clear.setStroke()

        path.fill()
        path.stroke()
    }

    private func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }

}
