//
//  NVActivityIndicatorShape.swift
//  NVActivityIndicatorViewDemo
//
//  Created by Nguyen Vinh on 7/22/15.
//  Copyright (c) 2015 Nguyen Vinh. All rights reserved.
//

import UIKit

enum NVActivityIndicatorShape {
    case circle
    case circleSemi
    case ring
    case ringTwoHalfVertical
    case ringTwoHalfHorizontal
    case ringThirdFour
    case rectangle
    case triangle
    case line
    case pacman
    
    func createLayerWith(size: CGSize, color: UIColor) -> CALayer {
        let layer: CAShapeLayer = CAShapeLayer()
        var path: UIBezierPath = UIBezierPath()
        let lineWidth: CGFloat = 2
        
        switch self {
        case .circle:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: 0,
                endAngle: 2 * CGFloat.pi,
                clockwise: false);
            layer.fillColor = color.cgColor
        case .circleSemi:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -CGFloat.pi / 6,
                endAngle: -5 * CGFloat.pi / 6,
                clockwise: false)
            path.close()
            layer.fillColor = color.cgColor
        case .ring:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: 0,
                endAngle: 2 * CGFloat.pi,
                clockwise: false);
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = lineWidth
        case .ringTwoHalfVertical:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -3 * (CGFloat.pi/4),
                endAngle: -(CGFloat.pi/4),
                clockwise: true)
            path.move(
                to: CGPoint(x: size.width / 2 - size.width / 2 * cos(CGFloat.pi/4),
                    y: size.height / 2 + size.height / 2 * sin(CGFloat.pi/4))
            )
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -5 * (CGFloat.pi/4),
                endAngle: -7 * (CGFloat.pi/4),
                clockwise: false)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = lineWidth
        case .ringTwoHalfHorizontal:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: 3 * (CGFloat.pi/4),
                endAngle: 5 * (CGFloat.pi/4),
                clockwise: true)
            path.move(
                to: CGPoint(x: size.width / 2 + size.width / 2 * cos(CGFloat.pi/4),
                    y: size.height / 2 - size.height / 2 * sin(CGFloat.pi/4))
            )
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -(CGFloat.pi/4),
                endAngle: (CGFloat.pi/4),
                clockwise: true)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = lineWidth
        case .ringThirdFour:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -3 * (CGFloat.pi/4),
                endAngle: -(CGFloat.pi/4),
                clockwise: false)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = 2
        case .rectangle:
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: size.width, y: 0))
            path.addLine(to: CGPoint(x: size.width, y: size.height))
            path.addLine(to: CGPoint(x: 0, y: size.height))
            layer.fillColor = color.cgColor
        case .triangle:
            let offsetY = size.height / 4
            
            path.move(to: CGPoint(x: 0, y: size.height - offsetY))
            path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2 - offsetY))
            path.addLine(to: CGPoint(x: size.width, y: size.height - offsetY))
            path.close()
            layer.fillColor = color.cgColor
        case .line:
            path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height),
                cornerRadius: size.width / 2)
            layer.fillColor = color.cgColor
        case .pacman:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 4,
                startAngle: 0,
                endAngle: 2 * CGFloat.pi,
                clockwise: true);
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = size.width / 2
        }
        
        layer.backgroundColor = nil
        layer.path = path.cgPath
        
        return layer
    }
}// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
