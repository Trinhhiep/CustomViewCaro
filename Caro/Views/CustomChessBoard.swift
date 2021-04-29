//
//  CustomChessBoard.swift
//  Caro
//
//  Created by Admin on 25/04/2021.
//

import Foundation
import UIKit

enum BoxType : Int {
    case CIRCLE = 0, X = 1
}

class CustomChessBoard: UIView {
    var delegate : UIChessBoardDelegate?
    var dataSource: UIChessBoardDataSource!
    
    var widthOfRect :CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        
        // add tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTaped(_:)))
        self.addGestureRecognizer(tap)
        
       
       
    }
    
    override func draw(_ rect: CGRect) {
        // number of column
        let numberOfColumn = dataSource.chessBoard(numberOfColum: self)
        widthOfRect = rect.width / CGFloat(numberOfColumn)
        
        // draw chess board
        for column in 0..<numberOfColumn {
            for row in 0..<numberOfColumn {
                let rectangle = CGRect(x: CGFloat(column) * widthOfRect!, y: CGFloat(row) * widthOfRect!, width: widthOfRect!, height: widthOfRect!)
                drawRectangle(rect: rectangle)
                
            }
        }
        //
        // draw selected box
        let numberOfBoxs = dataSource.chessBoard(numberOfBoxs: self)
        
        if numberOfBoxs == 0 {return}
        
        for index in 0..<numberOfBoxs {
            switch dataSource.chessBoard(self, boxTypeAt: index) {
            case .CIRCLE:
                drawCircle(point: dataSource.chessBoard(self, pointAt: index))
            case .X:
                drawX(point: dataSource.chessBoard(self, pointAt: index))
            }
        }
    }
    
    // rectanggle
    func drawRectangle(rect: CGRect)  {
        let color = UIColor.yellow
        let path = UIBezierPath(rect: rect)
        color.set()
        path.stroke()
    }
    
    // circle
    func drawCircle(point: CGPoint)  {
        
        let center = CGPoint(x: point.x * widthOfRect! + widthOfRect! / 2, y: point.y * widthOfRect! + widthOfRect! / 2)
        let circlePath = UIBezierPath(arcCenter: center, radius: CGFloat(widthOfRect!/3), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2 ), clockwise: true)
  
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.strokeEnd = 0.0
        shapeLayer.lineWidth = 3.0
        self.layer.addSublayer(shapeLayer)
        shapeLayer.strokeEnd = 1.0
        shapeLayer.add(createAnimation(), forKey: "line")
    }
    // draw x
    func drawX(point: CGPoint) {
        let center = CGPoint(x: point.x * widthOfRect! + widthOfRect! / 2, y: point.y * widthOfRect! + widthOfRect! / 2)
        let x = widthOfRect!/3
        let p1 = CGPoint(x: center.x - x, y: center.y - x)
        let p2 = CGPoint(x: center.x + x, y: center.y + x)
        let p3 = CGPoint(x: center.x - x, y: center.y + x)
        let p4 = CGPoint(x: center.x + x, y: center.y - x)
        
        // draw \

        let aPath1 = UIBezierPath()
        aPath1.move(to:p1)
        aPath1.addLine(to:p2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = aPath1.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.strokeEnd = 0.0 //chưa vẽ gì
        shapeLayer.lineWidth = 3.0
        self.layer.addSublayer(shapeLayer)
        shapeLayer.strokeEnd = 1.0// vẽ xong 100%
        shapeLayer.add(createAnimation(), forKey: "line1")
        //draw /
        let aPath2 = UIBezierPath()
        aPath2.move(to:p3)
        aPath2.addLine(to:p4)
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = aPath2.cgPath
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.strokeColor = UIColor.blue.cgColor
        shapeLayer2.strokeEnd = 0.0
        shapeLayer2.lineWidth = 3.0
        shapeLayer2.strokeEnd = 1.0
        self.layer.addSublayer(shapeLayer2)
        shapeLayer2.add(createAnimation(), forKey: "line2")
        
        
        
       
        
    }
    func createAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        return animation
    }
    func reloadData() {
        setNeedsDisplay()
    }
    
    @objc func didTaped(_ sender: UITapGestureRecognizer) {
        //
        let tapedPoint = sender.location(in: self)
        let p = CGPoint(x: Int(tapedPoint.x / widthOfRect!), y: Int(tapedPoint.y / widthOfRect!))
        guard let delegate = delegate else {
            return
        }
        delegate.chessBoard?(self, didSelectSquareAt: p)
    }
   
    
}

protocol UIChessBoardDataSource {
    func chessBoard(numberOfBoxs chessBoard: CustomChessBoard) -> Int
    func chessBoard(_ chessBoard: CustomChessBoard, pointAt index: Int) -> CGPoint
    func chessBoard(_ chessBoard: CustomChessBoard, boxTypeAt index: Int) -> BoxType
    func chessBoard(numberOfColum chessBoard : CustomChessBoard) -> Int
}

@objc protocol  UIChessBoardDelegate {
    @objc optional func chessBoard(_ chessBoard : CustomChessBoard, didSelectSquareAt point : CGPoint)
}



