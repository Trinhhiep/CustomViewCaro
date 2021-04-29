//
//  CustomLoadingView.swift
//  Caro
//
//  Created by Admin on 29/04/2021.
//

import Foundation
import UIKit
class CustomLoadingView: UIView {
    var dataSource : CustomLoadingDataSource?
    
    override func draw(_ rect: CGRect) {
        
        let percentOfLoading = (dataSource?.loadingView(self))!/100
        
        let widthOfRect = self.bounds.width

        let center = CGPoint(x: widthOfRect / 2, y: widthOfRect / 2)
        let circlePath = UIBezierPath(arcCenter: center, radius: CGFloat(self.bounds.width/3), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2 ), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor

        shapeLayer.strokeEnd = 0.0
        shapeLayer.lineWidth = 10.0
        
        self.layer.addSublayer(shapeLayer)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = percentOfLoading
        animation.duration = 1
        if percentOfLoading != 0.0 {
            shapeLayer.strokeEnd = CGFloat(percentOfLoading)
            shapeLayer.add(animation, forKey: "line")
        }
       
    }
    
    func reloadData() {
        setNeedsDisplay()
    }
}
protocol CustomLoadingDataSource {
    func loadingView(_ customLoadingView : CustomLoadingView) -> Float
}
