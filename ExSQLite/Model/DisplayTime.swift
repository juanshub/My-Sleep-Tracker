//
//  DisplayTime.swift
//  ExSQLite
//
//  Created by juna lin on 2023/3/29.
//

import UIKit

class DisplayTime: NSObject{
    var db :SQLiteConnect? = nil
    
    let sqliteURL: URL = {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("db.sqlite")
        } catch {
            fatalError("Error getting file URL from document directory.")
        }
    }()
    
    func Sleeptime()-> String {
        
        let sqlitePath = "/Users/junalin/Documents"
        
        print(sqlitePath)
        
        db = SQLiteConnect(path: sqlitePath)
        var hh:Int
        var mm:Int
        hh = 0
        mm = 0
        if let mydb = db {
            let statement = mydb.fetch1("SleepTime", cond: "1 == 1")
            
                while sqlite3_step(statement) == SQLITE_ROW{
                    hh = Int(sqlite3_column_int(statement, 4))
                    mm = Int(sqlite3_column_int(statement, 5))
                                    }
                    sqlite3_finalize(statement)

        }
        return "\(hh) : \(mm)"
    }
    
    func SleepDuration()-> String {
        
        let sqlitePath = "/Users/junalin/Documents"
        
        print(sqlitePath)
        
        db = SQLiteConnect(path: sqlitePath)
        var shh:Int
        var smm:Int
        var whh:Int
        var wmm:Int
        var total:Int
        shh = 0
        smm = 0
        whh = 0
        wmm = 0
        if let mydb = db {
            let statement = mydb.fetch1("SleepTime", cond: "1 == 1")
            
                while sqlite3_step(statement) == SQLITE_ROW{
                    shh = Int(sqlite3_column_int(statement, 4))
                    smm = Int(sqlite3_column_int(statement, 5))
                                    }
                    sqlite3_finalize(statement)

        }
        
        if let mydb = db {
            let statement = mydb.fetch1("WakeUpTime", cond: "1 == 1")
            
                while sqlite3_step(statement) == SQLITE_ROW{
                    whh = Int(sqlite3_column_int(statement, 4))
                    wmm = Int(sqlite3_column_int(statement, 5))
                                    }
                    sqlite3_finalize(statement)

        }
        
        if smm>30 {
            shh+=1
        }
        
        if wmm>30 {
            whh+=1
        }
        
        total = (24-shh)+whh
        
        return "\(total) hr"       
    }
    
}
