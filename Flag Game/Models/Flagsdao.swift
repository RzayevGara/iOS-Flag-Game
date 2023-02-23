//
//  Flagsdao.swift
//  Flag Game
//
//  Created by Rzayev Gara on 23.02.23.
//

import Foundation


class Flagsdao{
    let db: FMDatabase?
    
    init(){
        
        // viewcontroller icinde kopyaladigimiz database gedirik
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dataURL = URL(fileURLWithPath: target).appendingPathComponent("flagquiz.sqlite")
        
        db = FMDatabase(path: dataURL.path)
    }
    
    func randomTrueQuestion() ->[Flags]{
        var lists = [Flags]()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM flags ORDER BY RANDOM() LIMIT 5", values: nil)
            
            while(rs.next()){
                let flag = Flags(flag_id: Int(rs.string(forColumn: "flag_id"))!,
                                 flag_name: rs.string(forColumn: "flag_name")!,
                                 flag_image: rs.string(forColumn: "flag_image")!
                )
                lists.append(flag)
            }
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return lists
    }
    
    
    func randomFalseQuestion(flag_id: Int) ->[Flags]{
        var lists = [Flags]()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM flags WHERE flag_id != ? ORDER BY RANDOM() LIMIT 3", values: [flag_id])
            
            while(rs.next()){
                let flag = Flags(flag_id: Int(rs.string(forColumn: "flag_id"))!,
                                 flag_name: rs.string(forColumn: "flag_name")!,
                                 flag_image: rs.string(forColumn: "flag_image")!)
                lists.append(flag)
            }
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return lists
    }
}
