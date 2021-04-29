//
//  FirebaseSingleton.swift
//  Caro
//
//  Created by Admin on 26/04/2021.
//
import FirebaseDatabase
import Foundation
class FirebaseSingleton{
    public static var instance = FirebaseSingleton()
    
    var ref = Database.database().reference()
    
    private init(){}
    
    
    func addNode(_ node : Node)  {
        
        let x = node.x
        let y = node.y
        let id : String = "\(x):\(y)"
        
        self.ref.child("NODES").child(id).setValue(["x":node.x , "y" : node.y, "type" : node.type])
        
    }
    func deleteAll() {
        self.ref.child("NODES").removeValue()
    }
   
    func getNodes(_ completion: @escaping ([Node]) -> Void) {
        self.ref.child("NODES").observe(.value, with: { snapshot in
            guard snapshot.exists() else
            {
                print("Null")
                return
            }
            var nodes : [Node] = []
            guard let dictionary = snapshot.value as? [String: AnyObject] else {
                return
            }
            for item in dictionary {
                let node = Node(x: item.value["x"] as? Int ?? 0, y: item.value["y"] as? Int ?? 0, type: item.value["type"] as? Int ?? 0)
                nodes.append(node)
            }
            completion(nodes)
        })
    }
    
}

