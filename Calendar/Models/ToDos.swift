//
//  ToDos.swift
//  Calendar
//
//  Created by Aanya Jhaveri on 12/16/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation

class ToDo {
    var id: Int
    var name: String
    var status: Bool
    var sector: Sector
    
    init(id: Int, sector: Sector) {
        self.id = id
        self.name = "Name"
        self.status = false
        self.sector = sector
    }
    
    func updateName(name: String) {
        self.name = name
    }
    
    func changeSector(sector: Sector) {
        self.sector = sector
    }
    
    func createCustomSector(id: Int, name: String, r: Int, g: Int, b: Int) {
        sector = Sector(id: id)
        sector.updateName(name: name)
        sector.updateColorFromCustom(r: r, g: g, b: b)
    }
    
    func isDone() {
        self.status = !self.status
    }
    
    func saveToDB(db: OpaquePointer) {
        insertToDoData(table: self.sector.name, num: Int32(self.id), desc: self.name as NSString, done: self.status , db: db)
    }
    
    func updateToDB(db: OpaquePointer) {
        updateToDoData(name: self.name, table: self.sector.name, id: self.id, status: self.status, db: db)
    }
}
