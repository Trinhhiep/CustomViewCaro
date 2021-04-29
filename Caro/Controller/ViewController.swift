//
//  ViewController.swift
//  Caro
//
//  Created by Admin on 25/04/2021.
//

import UIKit

class ViewController: UIViewController{
    var boxs : [Node]?
    var numberOfColumn : Int?
    var id : Int = 0
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var customChessBoard: CustomChessBoard!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        customChessBoard.delegate = self
        customChessBoard.dataSource = self
        
        DispatchQueue.main.async {
            FirebaseSingleton.instance.getNodes() {[weak self] (data: [Node]) in
                self?.boxs = data
                
                self?.customChessBoard.reloadData()
               
            }
           
        }
       
    }
    
    override func viewDidLayoutSubviews() {
        
        self.customChessBoard.reloadData()
    }
    
}

extension ViewController : UIChessBoardDataSource, UIChessBoardDelegate{
    
    @objc(chessBoardWithNumberOfColum:) func chessBoard(numberOfColum chessBoard: CustomChessBoard) -> Int {
        return numberOfColumn!
    }

    func chessBoard(numberOfBoxs chessBoard: CustomChessBoard) -> Int {
        return boxs?.count ?? 0
    }
    
    func chessBoard(_ chessBoard: CustomChessBoard, pointAt index: Int) -> CGPoint {
        let node = boxs![index]
        return CGPoint(x: node.x, y: node.y)
    }
    
    func chessBoard(_ chessBoard: CustomChessBoard, boxTypeAt index: Int) -> BoxType {
        switch boxs![index].type {
        case 0:
            return .CIRCLE
        default:
            return .X
        }
    }
   
    
    func chessBoard(_ chessBoard: CustomChessBoard, didSelectSquareAt point: CGPoint) {
        
        
        let type: Int = id == 0 ? 1 : 0;
        
        let node = Node(x: Int(point.x), y: Int(point.y), type: type)
        if boxs != nil{
            if pointIsExist(node, boxs!){
                return
            }
            FirebaseSingleton.instance.addNode(node)
            id = type
        }else{
            FirebaseSingleton.instance.addNode(node)
            id = type
        }
        
       
    }
    
    func pointIsExist(_ node : Node, _ list : [Node]) -> Bool {
        
        return list.contains(where:{
            $0.x == node.x && $0.y == node.y
        })
    }
    
    
    
}
extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView : UIScrollView) -> UIView? {
        return customChessBoard
    }

}
