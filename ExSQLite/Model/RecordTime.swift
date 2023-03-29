//
//  RecordTime.swift
//  ExSQLite
//
//  Created by juna lin on 2023/3/28.
//

import UIKit

class RecordTime: NSObject{
    var db :SQLiteConnect? = nil
    
    let sqliteURL: URL = {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("db.sqlite")
        } catch {
            fatalError("Error getting file URL from document directory.")
        }
    }()
    
    func RecordSleep(yy: String,MM: String, dd: String,hh: String, mm: String){
        
        let sqlitePath = "/Users/junalin/Documents"
        
        print(sqlitePath)
        
        db = SQLiteConnect(path: sqlitePath)
        
        if let mydb = db {
            let _ = mydb.insert("SleepTime",
                                rowInfo: [ "year":yy,"month":MM,"day":dd,"hr":hh,"min":mm])
        }
    }
    
    func RecordWakeUp(yy: String,MM: String, dd: String,hh: String, mm: String){
        if let mydb = db {
            print("wakeUp")
            let _ = mydb.insert("WakeUpTime",
                                rowInfo: [ "year":yy,"month":MM,"day":dd,"hr":hh,"min":mm])
            
        }
        
        self.CalculateDuration()
    }
    
    func CalculateDuration(){
        print("calculate")
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
        print("total: \(total)")
        
        if let mydb = db {
            let _ = mydb.insert("duration",
                                rowInfo: [ "hr":"\(total)"])
            
        }
        
    }
}

