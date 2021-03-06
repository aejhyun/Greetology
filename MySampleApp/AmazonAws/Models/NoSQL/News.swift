//
//  News.swift
//  MySampleApp
//
//
// Copyright 2016 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-swift v0.3
//

import Foundation
import UIKit
import AWSDynamoDB

class News: AWSDynamoDBObjectModel, AWSDynamoDBModeling, AWSDynamoDBTable {
    
    var _userId: String?
    var _articleId: String?
    var _author: String?
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
    
    func setItemForKeyForTable(data: [String: AnyObject?]) {
        
    }
    
    func returnDynamoDBObjectModel() -> AWSDynamoDBObjectModel {
        return self
    }
    
    func returnAnyClass() -> AnyClass {
        return News.self
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
