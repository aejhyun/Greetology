//
//  DynamoDBTable.swift
//  Meetology
//
//  Created by Jae Hyun Kim on 9/12/16.
//
//

import Foundation
import AWSDynamoDB

class DynamoDBTable: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: AnyObject?
    var _articleId: AnyObject?
    var _author: AnyObject?
    var _category: String?
    var _content: String?
    var _creationDate: NSNumber?
    var _keywords: Set<String>?
    var _title: String?
    var test: [String]?
    var test1: [Int]?
    
    class func dynamoDBTableName() -> String {
        
        return "meetology-mobilehub-873546679-News"
    }
    
    class func hashKeyAttribute() -> String {
        
        return "_userId"
    }
    
    class func rangeKeyAttribute() -> String {
        
        return "_articleId"
    }
    
    func setValueForKeyForTable(data: [String: AnyObject?]) {
        for(key, value) in data {
            if key == "userId" {
                _userId = value
            } else if key == "articleId" {
                _articleId = value
            } else if key == "author" {
                _author = value
            }
        }
    }
    
    override class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject] {
        return [
            "_userId" : "userId",
            "_articleId" : "articleId",
            "_author" : "author",
            "_category" : "category",
            "_content" : "content",
            "_creationDate" : "creationDate",
            "_keywords" : "keywords",
            "_title" : "title",
        ]
    }
    
}