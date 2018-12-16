//
//  SQLiteToDoInterface.swift
//  Calendar
//
//  Created by Aanya Jhaveri on 12/16/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation

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


func createTable(sectorName: String, db: OpaquePointer) {
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

func deleteTable(sectorName: String, db: OpaquePointer) {
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

func renameTable(oldName: String, newName: String, db: OpaquePointer?) {
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

func insertData(table: String, num: Int32, desc: NSString, done: Int32, db: OpaquePointer) {
    let stringStatement = "INSERT OR IGNORE INTO [" + table + "ToDo" + "] (Id, Name, Color) Values (?, ?, ?)"
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

func returnData(table: String, db: OpaquePointer) -> [ToDo] {
    var sectorData: [ToDo] = []
    let returnStatement = "SELECT * FROM [" + table + "ToDo" + "];"
    var returnPointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, returnStatement, -2, &returnPointer,  nil) == SQLITE_OK {
        while sqlite3_step(returnPointer) == SQLITE_ROW {
            let id = sqlite3_column_int(returnPointer, 0)
            let cText = sqlite3_column_text(returnPointer, 1)
            let name = String(cString: cText!)
            let status = sqlite3_column_int(returnPointer, 2)
            
         //   let toDo = ToDo(id: Int(id), sector: )
           // toDo.
           // sectorData.append(sector)
        }
    } else {
        print("SELECT statement could not be prepared.")
    }
    sqlite3_finalize(returnPointer)
    return sectorData
}

func deleteData(table: String, id: Int32, db: OpaquePointer) {
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

func updateName(name: String, table: String, id: Int32, db: OpaquePointer) {
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

func updateColor(r: Int32, g: Int32, b: Int32, table: String, id: Int32, db: OpaquePointer) {
    let updateStatement = "UPDATE [" + table + "] SET Red = " + String(r) + ", \n"
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

func closeConnection(db: OpaquePointer) {
    if sqlite3_close(db) == SQLITE_OK {
        print("Database connection sucessfully closed.")
    } else {
        print("Database connection not sucessfully closed.")
    }
}



