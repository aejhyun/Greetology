//
//  NoSQLQueryResultViewController.swift
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

class NoSQLQueryResultViewController: UITableViewController {
    
    @IBOutlet weak var queryDescriptionLabel: UILabel!
    
    var queryType: String?
    var queryDescription: String?
    var table: Table?
    var paginatedOutput: AWSDynamoDBPaginatedOutput?
    var results: [AWSDynamoDBObjectModel]?
    var loading: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        queryDescriptionLabel.text = queryDescription
        title = queryType
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if results?.count > 0 {
            return results!.count
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if results?.count > 0 {
            return (table?.orderedAttributeKeys.count)!
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if results?.count > 0 {
            return "\(section+1)"
        } else {
            return " "
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if results?.count > 0 {
            showEditOptionsForIndexPath(indexPath)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if results?.count == 0 {
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("NoSQLQueryNoResultCell", forIndexPath: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("NoSQLQueryResultCell", forIndexPath: indexPath) as! NoSQLQueryResultCell
        let model = results?[indexPath.section]
        let modelDictionary: [NSObject : AnyObject] = model!.dictionaryValue
        let attributeKey = table?.tableAttributeName!(table!.orderedAttributeKeys[indexPath.row])
        cell.attributeNameLabel.text = attributeKey!
        cell.attributeValueLabel.text = "\(modelDictionary[(table?.orderedAttributeKeys[indexPath.row])!]!)"
        if (!loading) && (paginatedOutput?.lastEvaluatedKey != nil) && indexPath.section == self.results!.count - 1 {
            self.loadMoreResults()
        }
        return cell

    }
    
    // MARK: - User Action Methods
    
    func loadMoreResults() {
        loading = true
        paginatedOutput?.loadNextPageWithCompletionHandler({(error: NSError?) -> Void in
            if error != nil {
                print("Failed to load more results: \(error)")
                dispatch_async(dispatch_get_main_queue(), {
                    self.showAlertWithTitle("Error", message: "Failed to load more more results: \(error?.localizedDescription)")
                })
            }
            else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.results!.appendContentsOf(self.paginatedOutput!.items)
                    self.tableView.reloadData()
                    self.loading = false
                })
            }
        })
    }
    
    func showEditOptionsForIndexPath(indexPath: NSIndexPath) {
        let alartController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let updateAction: UIAlertAction = UIAlertAction(title: "Update", style: .Default, handler: {(action: UIAlertAction) -> Void in
            self.showUpdateConfirmationForIndexPath(indexPath)
        })
        let deleteAction: UIAlertAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {(action: UIAlertAction) -> Void in
            self.showDeleteConfirmationForIndexPath(indexPath)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alartController.addAction(updateAction)
        alartController.addAction(deleteAction)
        alartController.addAction(cancelAction)
        self.presentViewController(alartController, animated: true, completion: nil)
    }
    
    func showUpdateConfirmationForIndexPath(indexPath: NSIndexPath) {
        let alartController: UIAlertController = UIAlertController(title: nil, message: "Do you want to update your item?", preferredStyle: .ActionSheet)
        let proceedAction: UIAlertAction = UIAlertAction(title: "Update", style: .Default, handler: {(action: UIAlertAction) -> Void in
            self.updateItemForIndexPath(indexPath)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alartController.addAction(proceedAction)
        alartController.addAction(cancelAction)
        self.presentViewController(alartController, animated: true, completion: { _ in })
    }
    
    func updateItemForIndexPath(indexPath: NSIndexPath) {
        let item: AWSDynamoDBObjectModel = self.results![indexPath.section]
        
        let updateItemCompletionBlock: ([AWSDynamoDBObjectModel]) -> Void = { (items: [AWSDynamoDBObjectModel]) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: .Top, animated: false)
                self.results = items
                self.tableView.reloadData()
            })
        }
        
        table?.updateItem?(item, completionHandler: {(error: NSError?) -> Void in
            if let error = error { // Handle error if any
                var errorMessage = "Error Occurred: \(error.localizedDescription)"
                if (error.domain == AWSServiceErrorDomain && error.code == AWSServiceErrorType.AccessDeniedException.rawValue) {
                    errorMessage = "Access denied. You are not allowed to update this item."
                }
                self.showAlertWithTitle("Error", message: errorMessage)
                return
            }
            // Handle Get
            if (self.paginatedOutput == nil) {
                updateItemCompletionBlock([item])
            } else { // Handle Query / Scan (Paginated operations)
                self.paginatedOutput!.reloadWithCompletionHandler({(error: NSError?) -> Void in
                    updateItemCompletionBlock(self.paginatedOutput!.items)
                })
            }
        })
    }
    
    func showDeleteConfirmationForIndexPath(indexPath: NSIndexPath) {
        let alartController: UIAlertController = UIAlertController(title: nil, message: "Do you want to delete your item?", preferredStyle: .ActionSheet)
        let proceedAction: UIAlertAction = UIAlertAction(title: "Proceed", style: .Destructive, handler: {(action: UIAlertAction) -> Void in
            self.removeItemForIndexPath(indexPath)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alartController.addAction(proceedAction)
        alartController.addAction(cancelAction)
        self.presentViewController(alartController, animated: true, completion: nil)
    }
    
    func removeItemForIndexPath(indexPath: NSIndexPath) {
        table?.removeItem?(self.results![indexPath.section], completionHandler: {(error: NSError?) -> Void in
            if let error = error { // Handle error if any
                var errorMessage = "Error Occurred: \(error.localizedDescription)"
                if (error.domain == AWSServiceErrorDomain && error.code == AWSServiceErrorType.AccessDeniedException.rawValue) {
                    errorMessage = "Access denied. You are not allowed to delete this item."
                }
                self.showAlertWithTitle("Error", message: errorMessage)
                return
            }
            if (self.paginatedOutput == nil) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: .Top, animated: false)
                    self.results = []
                    self.tableView.reloadData()
                })
            }
            else {
                self.paginatedOutput!.reloadWithCompletionHandler({(error: NSError?) -> Void in
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: .Top, animated: false)
                        self.results = self.paginatedOutput!.items
                        self.tableView.reloadData()
                    })
                })
            }
        })
    }
    
    // MARK: - Utility Methods
    
    func showAlertWithTitle(title: String, message: String) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

class NoSQLQueryResultCell: UITableViewCell {
    
    @IBOutlet weak var attributeNameLabel: UILabel!
    @IBOutlet weak var attributeValueLabel: UILabel!
}