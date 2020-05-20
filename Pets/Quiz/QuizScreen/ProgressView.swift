//
//  ProgressView.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/16/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    private var progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    override func layoutSubviews() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: self.frame.height / 2))
        linePath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height / 2))
        progressLayer.path = linePath.cgPath
    }
    
    private func setUpUI() {
        setUpViewUI()
        setUpProgressLayer()
    }
    
    private func setUpViewUI() {
        self.layer.borderWidth = 1
        self.layer.borderColor = CommonValues.buttonsColor.cgColor
        self.backgroundColor = .clear
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    private func setUpProgressLayer() {
        progressLayer.strokeColor = CommonValues.buttonsColor.cgColor
        progressLayer.lineCap = .butt
        progressLayer.lineWidth = self.frame.height
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.fromValue = 1.0
        circularProgressAnimation.toValue = 0.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
