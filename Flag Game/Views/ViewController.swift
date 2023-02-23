//
//  ViewController.swift
//  Flag Game
//
//  Created by Rzayev Gara on 23.02.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataBaseCopy()
        startButton.layer.cornerRadius = 16
    }
    
    func dataBaseCopy(){
        
        // birinci database fayli hardadi onu deyirik
        let bundle = Bundle.main.path(forResource: "flagquiz", ofType: ".sqlite")
        
        // daha sonra save edeceyim yeri bildirirem
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        // file manager aliramki kopyalamani bunla edecik
        let fileManager = FileManager.default
        
        // kopyalanacaq yeri teyin edirik
        let copyDirectory = URL(fileURLWithPath: target).appendingPathComponent("flagquiz.sqlite")
        
        // kontrol ediremki, bele bir adda fayl var ya yox, varsa usdune yaziriq yoxdusa copy edirik.
        if fileManager.fileExists(atPath: copyDirectory.path){
            print("database var, kopyalamaga ehtiyac yoxdur")
        }else{
            print("database yoxdu, kopyala")
            
            do{
                try fileManager.copyItem(atPath: bundle!, toPath: copyDirectory.path)
            }catch{
                print("error")
            }
        }
    }


}

