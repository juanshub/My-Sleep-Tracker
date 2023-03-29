//
//  BarChart.swift
//  ExSQLite
//
//

import Charts
import SwiftUI
 
struct Product: Identifiable {
    var id = UUID()
    var name: String
    var count: Int
    var color: Color
}
struct BarChart: View {
    var products: [Product] = [
        .init(name: "3/20", count: 7, color: .init(uiColor: UIColor(displayP3Red: 0.08, green: 0.23, blue: 0.54, alpha: 1))),
        .init(name: "3/21", count: 8, color: .init(uiColor: UIColor(displayP3Red: 0.05, green: 0.2, blue: 0.47, alpha: 1))),
        .init(name: "3/22", count: 9, color: .init(uiColor: UIColor(displayP3Red: 0, green: 0.13, blue: 0.34, alpha: 1))),
        .init(name: "3/23", count: 6, color: .init(uiColor: UIColor(displayP3Red: 0.003, green: 0.12, blue: 0.31, alpha: 1))),
        .init(name: "3/24", count: 7, color: .init(uiColor: UIColor(displayP3Red: 0, green: 0.11, blue: 0.33, alpha: 1)))
        
    ]
    
    init(){
        var db :SQLiteConnect? = nil
        
        let sqlitePath = "/Users/junalin/Documents"
        
        print(sqlitePath)
        
        db = SQLiteConnect(path: sqlitePath)
        
        var arr = [0, 0, 0, 0, 0]
        var i:Int
        i = 0

        
        if let mydb = db {
            let statement = mydb.fetch2("Duration", cond: "1 == 1")
            
                while sqlite3_step(statement) == SQLITE_ROW{
                    arr[i] = Int(sqlite3_column_int(statement, 1))
                    i+=1
                                    }
                    sqlite3_finalize(statement)

        }
        i = 0
        products[4].count = arr[0]
        products[3].count = arr[1]
        products[2].count = arr[2]
        products[1].count = arr[3]
        products[0].count = arr[4]
        
        var MM = [0, 0, 0, 0, 0]
        var dd = [0, 0, 0, 0, 0]
        if let mydb = db {
            let statement = mydb.fetch2("SleepTime", cond: "1 == 1")
            
                while sqlite3_step(statement) == SQLITE_ROW{
                    MM[i] = Int(sqlite3_column_int(statement, 2))
                    dd[i] = Int(sqlite3_column_int(statement, 3))
                    i+=1
                                    }
                    sqlite3_finalize(statement)

        }
        products[4].name = "\(MM[0])/\(dd[0])"
        products[3].name = "\(MM[1])/\(dd[1])"
        products[2].name = "\(MM[2])/\(dd[2])"
        products[1].name = "\(MM[3])/\(dd[3])"
        products[0].name = "\(MM[4])/\(dd[4])"
    }
    
    
    
    var body: some View {
        Chart(products) { item in
            BarMark(
                x: .value("日期", item.name),
                y: .value("睡眠時數", item.count)
            )
            .foregroundStyle(item.color)
        }
    }
}

