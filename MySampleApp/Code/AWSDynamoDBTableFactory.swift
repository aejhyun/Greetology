//
//  TableFactory.swift
//  Meetology
//
//  Created by Jae Hyun Kim on 9/12/16.
//
//

import Foundation
import AWSDynamoDB

class AWSDynamoDBTableFactory {
    
    static let sharedInstance: AWSDynamoDBTableFactory = AWSDynamoDBTableFactory()
    
    func getTable(tableName: String) -> AWSDynamoDBTable? {
        switch tableName {
        case "News":
            return News()
        case "TestTable":
            return TestTable()
        default:
            return nil
        }
    }

}

protocol AWSDynamoDBTable {
    func setItemForKeyForTable(item: [String: AnyObject?])
    func returnDynamoDBObjectModel() -> AWSDynamoDBObjectModel
    func returnAnyClass() -> AnyClass
    
}