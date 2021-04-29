//
//  LoadingViewController.swift
//  Caro
//
//  Created by Admin on 29/04/2021.
//

import UIKit

class LoadingViewController: UIViewController {
    var p: Float = 0.0
    @IBOutlet weak var loadingView: CustomLoadingView!
    @IBOutlet weak var tfPercent: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClick(_ sender: Any) {
      let data = tfPercent.text
        guard Float(data!) != nil else {
            print("Vui lòng nhập số")
            return
        }
        
        p = Float(data ?? "0.0")!
        if p > 1 && p < 100 {
            loadingView.reloadData()
        }
        else{
            print("Phải thuộc khoảng 1 -> 100")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LoadingViewController : CustomLoadingDataSource{
    func loadingView(_ customLoadingView: CustomLoadingView) -> Float {
        return p
    }
    
    
}
