//
//  SQLiteInterface.swift
//
//  Calendar
//
//  Created by Aanya Jhaveri on 8/27/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation
import SQLite3
import UIKit

struct Path {
    static let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("RoutineDatabase.sqlite")
}

// open database connection

func openConnection() -> OpaquePointer? {
    var db: OpaquePointer? = nil
    if sqlite3_open(Path.fileURL.path, &db) == SQLITE_OK {
        print("Connection to \(Path.fileURL) successfully opened")
        return db
    } else {
        print("Unable to establish connection to database. Verify that database was created.")
        return db
    }
}

// create tables
func createSectorTable(name: String, db: OpaquePointer) {
    let stringStatement = "CREATE TABLE IF NOT EXISTS [" + name + "] ( \n"
        + "Id INT PRIMARY KEY NOT NULL,\n"
        + "NAME CHAR(255),\n"
        + "RED INT, \n"
        + "GREEN INT, \n"
        + "BLUE INT);"
    var createPointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, stringStatement, -1, &createPointer, nil) == SQLITE_OK {
        if sqlite3_step(createPointer) == SQLITE_DONE {
            print("\(name) table created.")
        } else {
            print("\(name) table was not created.")
        }
    } else {
        print("The table already exists or there is an error in the SQLite code.")
    }
    sqlite3_finalize(createPointer)
}


func createToDoTable(sectorName: String, db: OpaquePointer) {
    let stringStatement = "CREATE TABLE IF NOT EXISTS [" + sectorName + "ToDo" + "] ( \n"
        + "Id INT PRIMARY KEY NOT NULL,\n"
        + "NAME CHAR(255),\n"
        + "STATUS INT);"
    var createPointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, stringStatement, -1, &createPointer, nil) == SQLITE_OK {
        if sqlite3_step(createPointer) == SQLITE_DONE {
            print("\(sectorName) table created.")
        } else {
            print("\(sectorName) table was not created.")
        }
    } else {
        print("The table already exists or there is an error in the SQLite code.")
    }
    sqlite3_finalize(createPointer)
}

// delete tables

func deleteSectorTable(name: String, db: OpaquePointer) {
    let deleteStatement = "DROP TABLE IF EXISTS [" + name + "]"
    var deletePointer : OpaquePointer? = nil
    if sqlite3_prepare_v2(db, deleteStatement, -1, &deletePointer, nil) == SQLITE_OK {
        if sqlite3_step(deletePointer) == SQLITE_DONE {
            print("\(name) table sucessfully deleted")
        } else {
            print("\(name) could not be deleted")
        }
    } else {
        print("Delete statement could not be prepared.")
    }
    sqlite3_finalize(deletePointer)
}

func deleteToDoTable(sectorName: String, db: OpaquePointer) {
    let deleteStatement = "DROP TABLE IF EXISTS [" + sectorName + "ToDo" + "]"
    var deletePointer : OpaquePointer? = nil
    if sqlite3_prepare_v2(db, deleteStatement, -1, &deletePointer, nil) == SQLITE_OK {
        if sqlite3_step(deletePointer) == SQLITE_DONE {
            print("\(sectorName) table sucessfully deleted")
        } else {
            print("\(sectorName) could not be deleted")
        }
    } else {
        print("Delete statement could not be prepared.")
    }
    sqlite3_finalize(deletePointer)
}

// return list of names of tables

func returnTables(db: OpaquePointer) -> [String] {
    var tables: [String] = []
    let returnStatement = "SELECT name FROM sqlite_master where type = 'table'"
    var returnPointer : OpaquePointer? = nil
    if sqlite3_prepare_v2(db, returnStatement, -1, &returnPointer, nil) == SQLITE_OK {
        while sqlite3_step(returnPointer) == SQLITE_ROW {
            let cText = sqlite3_column_text(returnPointer, 0)
            let title = String(cString: cText!)
            tables.append(title)
        }
    }  else {
        print("Table names could not be returned.")
    }
    sqlite3_finalize(returnPointer)
    return tables
}

// rename tables

func renameSectorTable(oldName: String, newName: String, db: OpaquePointer?) {
    let renameStatement = "ALTER TABLE [" + oldName + "] \n"
        + "RENAME TO [" + newName + "];"
    var renamePointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, renameStatement, -1, &renamePointer, nil) == SQLITE_OK {
        if sqlite3_step(renamePointer) == SQLITE_DONE {
            print("\(oldName) sucessfully renamed as \(newName)")
        } else {
            print("Table could not be renamed.")
        }
    } else {
        print("Rename statement could not be prepared.")
    }
    sqlite3_finalize(renamePointer)
}

func renameToDoTable(oldName: String, newName: String, db: OpaquePointer?) {
    let renameStatement = "ALTER TABLE [" + oldName + "ToDo" +  "] \n"
        + "RENAME TO [" + newName + "ToDo" + "];"
    var renamePointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, renameStatement, -1, &renamePointer, nil) == SQLITE_OK {
        if sqlite3_step(renamePointer) == SQLITE_DONE {
            print("\(oldName) sucessfully renamed as \(newName)")
        } else {
            print("Table could not be renamed.")
        }
    } else {
        print("Rename statement could not be prepared.")
    }
    sqlite3_finalize(renamePointer)
}

// insert data into tables

func insertSectorData(table: String, num: Int32, desc: NSString, r: Int32, g: Int32, b: Int32, db: OpaquePointer) {
    let stringStatement = "INSERT OR IGNORE INTO [" + table + "] (Id, Name, Red, Green, Blue) Values (?, ?, ?, ?, ?)"
    var insertPointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, stringStatement, -1, &insertPointer, nil) == SQLITE_OK {
        let id = num
        let name = desc
        let red = r
        let green = g
        let blue = b
        
        sqlite3_bind_int(insertPointer, 1, id)
        sqlite3_bind_text(insertPointer, 2, name.utf8String, -1, nil)
        sqlite3_bind_int(insertPointer, 3, red)
        sqlite3_bind_int(insertPointer, 4, green)
        sqlite3_bind_int(insertPointer, 5, blue)
        
        if sqlite3_step(insertPointer) == SQLITE_DONE {
            print("Sucessfully inserted (\(id), \(name), (\(red),\(green),\(blue)) into table \(table).")
        } else {
            print("Data could not be inserted.")
        }
    } else {
        print("INSERT statement could not be prepared")
    }
    sqlite3_finalize(insertPointer)
}

func insertToDoData(table: String, num: Int32, desc: NSString, done: Int32, db: OpaquePointer) {
    let stringStatement = "INSERT OR IGNORE INTO [" + table + "ToDo" + "] (Id, Name, Status) Values (?, ?, ?)"
    var insertPointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, stringStatement, -1, &insertPointer, nil) == SQLITE_OK {
        let id = num
        let name = desc
        let status = done
        
        sqlite3_bind_int(insertPointer, 1, id)
        sqlite3_bind_text(insertPointer, 2, name.utf8String, -1, nil)
        sqlite3_bind_int(insertPointer, 3, status)
        
        if sqlite3_step(insertPointer) == SQLITE_DONE {
            print("Sucessfully inserted (\(id), \(name), \(status) into table \(table)ToDo.")
        } else {
            print("Data could not be inserted.")
        }
    } else {
        print("INSERT statement could not be prepared")
    }
    sqlite3_finalize(insertPointer)
}

// return data from tables

func returnSectorData(table: String, db: OpaquePointer) -> [Sector] {
    var sectorData: [Sector] = []
    let returnStatement = "SELECT * FROM [" + table + "];"
    var returnPointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, returnStatement, -2, &returnPointer,  nil) == SQLITE_OK {
        while sqlite3_step(returnPointer) == SQLITE_ROW {
            let id = sqlite3_column_int(returnPointer, 0)
            let cText = sqlite3_column_text(returnPointer, 1)
            let name = String(cString: cText!)
            let red = sqlite3_column_int(returnPointer, 2)
            let green = sqlite3_column_int(returnPointer, 3)
            let blue = sqlite3_column_int(returnPointer, 4)
            
            let sector = Sector(id: Int(id))
            sector.updateName(name: name)
            sector.updateColorFromCustom(r: Int(red), g: Int(green), b: Int(blue))
            
            sectorData.append(sector)
        }
    } else {
        print("SELECT statement could not be prepared.")
    }
    sqlite3_finalize(returnPointer)
    return sectorData
}

func returnToDoData(table: String, db: OpaquePointer) -> [ToDo] {
    var toDoData: [ToDo] = []
    let returnStatement = "SELECT * FROM [" + table + "ToDo" + "];"
    var returnPointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, returnStatement, -2, &returnPointer,  nil) == SQLITE_OK {
        while sqlite3_step(returnPointer) == SQLITE_ROW {
            let id = sqlite3_column_int(returnPointer, 0)
            let cText = sqlite3_column_text(returnPointer, 1)
            let name = String(cString: cText!)
            let status = sqlite3_column_int(returnPointer, 2)
            
            let toDo = ToDo(id: Int(id), sector: Sector(id: 0))
            toDo.updateName(name: name)
            if status == 1{
                toDo.isDone()
            }
            toDoData.append(toDo)
        }
    } else {
        print("SELECT statement could not be prepared.")
    }
    sqlite3_finalize(returnPointer)
    return toDoData
}

// delete data from tables

func deleteSectorData(table: String, id: Int32, db: OpaquePointer) {
    let deleteStatement = "DELETE FROM [" + table + "] WHERE Id = " + String(id) + ";"
    var deletePointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, deleteStatement, -1, &deletePointer, nil) == SQLITE_OK {
        if sqlite3_step(deletePointer) == SQLITE_DONE {
            print("Row deleted.")
        } else {
            print("Row could not be deleted.")
        }
    } else {
        print("DELETE statement could not be prepared.")
    }
    sqlite3_finalize(deletePointer)
}

func deleteToDoData(table: String, id: Int32, db: OpaquePointer) {
    let deleteStatement = "DELETE FROM [" + table + "ToDo] WHERE Id = " + String(id) + ";"
    var deletePointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, deleteStatement, -1, &deletePointer, nil) == SQLITE_OK {
        if sqlite3_step(deletePointer) == SQLITE_DONE {
            print("Row deleted.")
        } else {
            print("Row could not be deleted.")
        }
    } else {
        print("DELETE statement could not be prepared.")
    }
    sqlite3_finalize(deletePointer)
}

// update data from tables

func updateSectorName(name: String, table: String, id: Int32, db: OpaquePointer) {
    let updateStatement = "UPDATE [" + table + "] SET Name = '" + name + "' WHERE Id = " + String(id) + ";"
    var updatePointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, updateStatement, -1, &updatePointer, nil) == SQLITE_OK {
        if sqlite3_step(updatePointer) == SQLITE_DONE {
            print("Successfully updated row.")
        } else {
            print("Row could not be updated.")
        }
    } else {
        print("UPDATE statement could not be prepared.")
    }
    sqlite3_finalize(updatePointer)
}

func updateSectorData(name: String, r: Int, g: Int, b: Int, table: String, id: Int, db: OpaquePointer) {
    let updateStatement = "UPDATE [" + table + "] SET Name = '" + name + "', \n"
                          + "Red = " + String(r) + ", \n"
                          + "Green = " + String(g) + ", \n"
                          + "Blue = " + String(b)
                          + "WHERE Id = " + String(id) + ";"
    var updatePointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, updateStatement, -1, &updatePointer, nil) == SQLITE_OK {
        if sqlite3_step(updatePointer) == SQLITE_DONE {
            print("Successfully updated row.")
        } else {
            print("Row could not be updated.")
        }
    } else {
        print("UPDATE statement could not be prepared.")
    }
    sqlite3_finalize(updatePointer)
}

func updateToDoData(name: String, table: String, id: Int, status: Int, db: OpaquePointer) {
    let updateStatement = "UPDATE [" + table + "ToDo] SET Name = '" + name + "',\n"
                          + "Status = " + String(status)
                          + "WHERE Id = " + String(id) + ";"
    var updatePointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, updateStatement, -1, &updatePointer, nil) == SQLITE_OK {
        if sqlite3_step(updatePointer) == SQLITE_DONE {
            print("Sucessfully updated row.")
        } else {
            print("Row could not be updated.")
        }
    } else {
        print("UPDATE statement could not be prepared.")
    }
    sqlite3_finalize(updatePointer)
}

// close database connection

func closeConnection(db: OpaquePointer) {
    if sqlite3_close(db) == SQLITE_OK {
        print("Database connection sucessfully closed.")
    } else {
        print("Database connection not sucessfully closed.")
    }
}



