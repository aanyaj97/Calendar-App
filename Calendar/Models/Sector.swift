//
//  Sector.swift
//  Calendar
//
//  Created by Aanya Jhaveri on 12/16/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation
import UIKit


class Sector {
    var id: Int
    var name: String
    var color: (Int, Int, Int)
    
    init(id: Int) {
        self.id = id
        self.name = "Sector"
        self.color = (211, 211, 211)
    }
    
    func updateColorFromSelection(color: (Int, Int, Int)) {
        self.color = color
    }
    
    func updateColorFromCustom(r: Int, g: Int, b: Int, db: OpaquePointer) {
        self.color = (r,g,b)
        updateSectorColor(r: Int32(self.color.0), g: Int32(self.color.1), b: Int32(self.color.2), table: "Sectors", id: Int32(self.id), db: db)
    }
    
    func updateName(name: String, db: OpaquePointer) {
        self.name = name
        updateSectorName(name: self.name, table: "Sectors", id: Int32(self.id), db: db)
    }
    
    func returnUIColor() -> UIColor {
        return UIColor(red: CGFloat(self.color.0), green: CGFloat(self.color.1), blue: CGFloat(self.color.2), alpha: CGFloat(1.0))
    }
    
    func saveToDB(db: OpaquePointer) {
        insertSectorData(table: "Sectors", num: Int32(self.id), desc: self.name as NSString, r: Int32(self.color.0), g: Int32(self.color.1), b: Int32(self.color.2), db: db)
    }
}
