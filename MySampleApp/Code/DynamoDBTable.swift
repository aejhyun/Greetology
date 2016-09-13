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
    
    var userId: AnyObject?
    var articleId: AnyObject?
    var author: AnyObject?
    
    init(items: [String: AnyObject?]) {
        super.init()
        
        for(key, value) in items {
            if key == "userId" {
                userId = value
            } else if key == "articleId" {
                articleId = value
            } else if key == "author" {
                author = value
            }
        }
    }
    
    required init!(coder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func dynamoDBTableName() -> String {
        
        return "meetology-mobilehub-873546679-News"
    }
    
    class func hashKeyAttribute() -> String {
        
        return "_userId"
    }
    
    class func rangeKeyAttribute() -> String {
        
        return "_articleId"
    }
    
    func setValueForKeyForDynamoDBTable(data: [String: AnyObject]) {
        for(key, value) in data {
            if key == "userId" {
                userId = value
            } else if key == "articleId" {
                articleId = value
            } else if key == "author" {
                author = value
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