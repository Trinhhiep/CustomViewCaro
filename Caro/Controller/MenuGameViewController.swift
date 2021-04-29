//
//  MenuGameViewController.swift
//  Caro
//
//  Created by Admin on 28/04/2021.
//

import UIKit

class MenuGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func btnOption3x3(_ sender: Any) {
        goToGamePage(3)
    }
    
    @IBAction func btnOption10x10(_ sender: Any) {
        goToGamePage(10)
    }
    
    @IBAction func btnOption15x15(_ sender: Any) {
        goToGamePage(15)
     }
    func goToGamePage(_ numberOfColumn : Int)  {
        FirebaseSingleton.instance.deleteAll()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let gamePage = sb.instantiateViewController(withIdentifier: "GAMEPAGE") as! ViewController
        gamePage.numberOfColumn = numberOfColumn
        self.navigationController?.pushViewController(gamePage, animated: true)
    }

}
