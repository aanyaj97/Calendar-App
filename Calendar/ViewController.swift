//
//  ViewController.swift
//  Calendar
//
//  Created by Aanya Jhaveri on 11/23/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let db = openConnection()
        if let db = db {
            createToDoTable(sectorName: "Home", db: db)
            print(returnTables(db: db))
            insertToDoData(table: "Home", num: 1, desc: "Clean Room" as NSString, done: 1, db: db)
            print(returnToDoData(table: "Home", db: db))
            deleteToDoData(table: "Home", id: 1, db: db)
            print(returnToDoData(table: "Home", db: db))
            deleteToDoTable(sectorName: "Home", db: db)
            print(returnTables(db: db))
            closeConnection(db: db)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

