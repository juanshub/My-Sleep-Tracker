//
//  ViewController2.swift
//  ExSQLite

import UIKit
import SwiftUI

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBSegueAction func MyChart(_ coder: NSCoder) -> UIViewController? {
        UIHostingController(coder: coder, rootView: BarChart())
    }
}
