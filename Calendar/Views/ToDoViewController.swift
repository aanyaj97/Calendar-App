//
//  toDoViewController.swift
//  Calendar
//
//  Created by Aanya Jhaveri on 12/21/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController, UITableViewDataSource {
    
    let toDoView = UITableView()
    toDoView.datasource = self
    
    func pullData() {
        // pull SQLite data for display
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkTheme.background
        view.addSubview(toDoView)
        toDoView.translatesAutoresizingMaskIntoConstraints = false
        toDoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        toDoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        toDoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        toDoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
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
