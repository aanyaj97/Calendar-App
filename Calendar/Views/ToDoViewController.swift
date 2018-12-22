//
//  toDoViewController.swift
//  Calendar
//
//  Created by Aanya Jhaveri on 12/21/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController, UITableViewDataSource {
    
    func addData() {
        let db = openConnection()
        if let db = db {
            createSectorTable(name: "Sectors", db: db)
            insertSectorData(table: "Sectors", num: 0, desc: "Home", r: 45, g: 45, b: 45, db: db)
            createToDoTable(sectorName: "Home", db: db)
            insertToDoData(table: "Home", num: 0, desc: "Clean Room", done: false, db: db)
            insertToDoData(table: "Home", num: 1, desc: "Cook Dinner", done: false, db: db)
        }
    }
    
    let toDoView = UITableView()
    
    func pullData() -> [ToDo] {
        let db = openConnection()
        if let db = db {
            return returnToDoData(table: "Home", db: db)
        }
        else {
            return []
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = pullData()
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = pullData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addData()
        view.backgroundColor = darkTheme.background
        view.addSubview(toDoView)
        toDoView.translatesAutoresizingMaskIntoConstraints = false
        toDoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        toDoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        toDoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        toDoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        toDoView.dataSource = self
        toDoView.register(UITableViewCell.self, forCellReuseIdentifier: "toDoCell")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
