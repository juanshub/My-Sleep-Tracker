//
//  ViewController.swift
//  ExSQLite

import UIKit

class ViewController: UIViewController {
    
    var db :SQLiteConnect? = nil
    let recordTime:RecordTime = RecordTime()
    let displayTime:DisplayTime = DisplayTime()
    
    let sqliteURL: URL = {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("db.sqlite")
        } catch {
            fatalError("Error getting file URL from document directory.")
        }
    }()
    
    
    
    
    @IBOutlet weak var DurationText: UILabel!
    @IBOutlet weak var SleepTimeText: UILabel!
    
    @IBOutlet weak var SleepBT: UIButton!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var WakeUpBT: UIButton!
    
    @IBOutlet weak var TimeText: UILabel!
    var timer: Timer?
    
    @objc func MyTimer(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH : mm"
        let timeString = dateFormatter.string(from: Date())
        print(timeString)
        TimeText.text = timeString
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyTimer()
        self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector:#selector(MyTimer), userInfo: nil, repeats: true)
        SleepTimeText.text = displayTime.Sleeptime()
        DurationText.text = displayTime.SleepDuration()
        
        // db path
        let sqlitePath = "/Users/junalin/Documents"
        
        print(sqlitePath)
        
        // SQLite database
        db = SQLiteConnect(path: sqlitePath)
        
        
        if let mydb = db {
            // create table
            let _ = mydb.createTable("WakeUpTime", columnsInfo: [
                "id integer primary key autoincrement",
                "year int","month int","day int","hr int","min int"])
            let _ = mydb.createTable("SleepTime", columnsInfo: [
                "id integer primary key autoincrement",
                "year int","month int","day int","hr int","min int"])
            let _ = mydb.createTable("Duration", columnsInfo: [
                "id integer primary key autoincrement",
                "hr int"])
            
        }
        
        
    }
    @IBAction func WbuttonAction(_ sender: Any) {
        var MHString:String
        var yy:String
        var MM:String
        var dd:String
        var hh:String
        var mm:String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        let DateComponents = dateString.components(separatedBy: "-")
        yy = DateComponents[0]
        MM = DateComponents[1]
        dd = DateComponents[2]
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        MHString = timeFormatter.string(from: DatePicker.date)
        let timeComponents = MHString.components(separatedBy: ":")
        
        hh = timeComponents[0]
        mm = timeComponents[1]
        recordTime.RecordWakeUp(yy: yy,MM: MM,dd: dd,hh: hh,mm: mm)
        
    }
    @IBAction func SbuttonAction(_ sender: Any) {
            var MHString:String
            var yy:String
            var MM:String
            var dd:String
            var hh:String
            var mm:String
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: Date())
            let DateComponents = dateString.components(separatedBy: "-")
            yy = DateComponents[0]
            MM = DateComponents[1]
            dd = DateComponents[2]
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            MHString = timeFormatter.string(from: DatePicker.date)
            let timeComponents = MHString.components(separatedBy: ":")
            
            hh = timeComponents[0]
            mm = timeComponents[1]

        recordTime.RecordSleep(yy: yy,MM: MM,dd: dd,hh: hh,mm: mm)
            
            
        }

    
    
}
