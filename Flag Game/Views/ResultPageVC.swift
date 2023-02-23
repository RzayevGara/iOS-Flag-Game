//
//  ResultPageVC.swift
//  Flag Game
//
//  Created by Rzayev Gara on 23.02.23.
//

import UIKit

class ResultPageVC: UIViewController {
    
    @IBOutlet weak var labelResult: UILabel!
    

    @IBOutlet weak var labelSuccess: UILabel!
    
    @IBOutlet weak var tryButton: UIButton!
    
    var trueCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tryButton.layer.cornerRadius = 16
        
        navigationItem.hidesBackButton = true
        
        if let d = trueCount {
            labelResult.text = "\(d) True \(5-d) False"
            labelSuccess.text = "\(d*100/5)% Success"
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
