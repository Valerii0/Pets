//
//  ProgressView.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/16/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //createCircularPath()
    }
    
    func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: self.frame.height / 2, startAngle: 3 * .pi / 2, endAngle: 3 * .pi / 1.95, clockwise: false)
        //        circleLayer.path = circularPath.cgPath
        //        circleLayer.fillColor = UIColor.clear.cgColor
        //        circleLayer.lineCap = .round
        //        circleLayer.lineWidth = 10.0
        //        circleLayer.strokeColor = UIColor.black.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.black.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 15.0
        progressLayer.strokeEnd = 10
        progressLayer.strokeColor = UIColor.green.cgColor
        //layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        let gradientLAyer = CAGradientLayer()
                gradientLAyer.colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
                gradientLAyer.locations = [0, 1]
                gradientLAyer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
                let animation = CABasicAnimation(keyPath: "transform.translation.y")
                animation.duration = duration
                animation.fromValue = -self.frame.height
                animation.toValue = 0.0
        
                gradientLAyer.add(animation, forKey: nil)
        
                self.layer.addSublayer(gradientLAyer)
        
//        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: self.frame.height / 2, startAngle: 3 * .pi / 2, endAngle: 3 * .pi / 1.95, clockwise: false)
//               //        circleLayer.path = circularPath.cgPath
//               //        circleLayer.fillColor = UIColor.clear.cgColor
//               //        circleLayer.lineCap = .round
//               //        circleLayer.lineWidth = 10.0
//               //        circleLayer.strokeColor = UIColor.black.cgColor
//               progressLayer.path = circularPath.cgPath
//               progressLayer.fillColor = UIColor.black.cgColor
//               progressLayer.lineCap = .round
//               progressLayer.lineWidth = 15.0
//               progressLayer.strokeEnd = 10
//               progressLayer.strokeColor = UIColor.green.cgColor
//               //layer.addSublayer(circleLayer)
//               layer.addSublayer(progressLayer)
//        
//        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        circularProgressAnimation.duration = duration
//        circularProgressAnimation.fromValue = 1.0
//        circularProgressAnimation.toValue = 0.0
//        //circularProgressAnimation.fillMode = .forwards
//        //circularProgressAnimation.isRemovedOnCompletion = false
//        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}


//private func createCircularPath() {
//        //let circularPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.width, height: 1))
//        //UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: self.frame.height / 2, startAngle: 3 * .pi / 2, endAngle: 3 * .pi / 1.95, clockwise: false)
//        //        circleLayer.path = circularPath.cgPath
//        //        circleLayer.fillColor = UIColor.clear.cgColor
//        //        circleLayer.lineCap = .round
//        //        circleLayer.lineWidth = 10.0
//        //        circleLayer.strokeColor = UIColor.black.cgColor
//        progressLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
//        //progressLayer.path = circularPath.cgPath
//        progressLayer.fillColor = CommonValues.buttonsColor.cgColor//UIColor.clear.cgColor
//        //progressLayer.lineCap = .round
//        //progressLayer.lineWidth = 2//self.frame.height//5.0
//        //progressLayer.strokeEnd = 0
//        progressLayer.strokeColor = CommonValues.buttonsColor.cgColor//UIColor.green.cgColor
//        //layer.addSublayer(circleLayer)
//        layer.addSublayer(progressLayer)
//    }
//
//    func progressAnimation(duration: TimeInterval) {
////        let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
////        progressAnimation.duration = duration
////        progressAnimation.fromValue = 1.0
////        progressAnimation.toValue = 0.0
////        //progressAnimation.fillMode = .forwards
////        //circularProgressAnimation.isRemovedOnCompletion = false
////        progressLayer.add(progressAnimation, forKey: "progressAnim")
//    }
//
//    private func makeAnimationRoad(with roadView: UIView, duration: Double) {
//        let gradientLAyer = CAGradientLayer()
//        gradientLAyer.colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
//        gradientLAyer.locations = [0, 1]
//        gradientLAyer.frame = CGRect(x: 0, y: 0, width: roadView.frame.width, height: roadView.frame.height)
//
//        let animation = CABasicAnimation(keyPath: "transform.translation.y")
//        animation.duration = duration
//        animation.fromValue = -roadView.frame.height
//        animation.toValue = 0.0
//
//        gradientLAyer.add(animation, forKey: nil)
//
//        roadView.layer.addSublayer(gradientLAyer)
//    }
