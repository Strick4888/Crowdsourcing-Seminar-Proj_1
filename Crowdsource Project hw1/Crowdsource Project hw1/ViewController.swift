//
//  ViewController.swift
//  Crowdsource Project hw1
//
//  Created by Benjamin Strick on 9/24/15.
//  Copyright (c) 2015 Benjamin Strick. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {


    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var tableViewArray:[Message] = Array()
    
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let testObject:PFObject = PFObject(className: "TestClass")
        //testObject["SomeProperty"] = "SomeValue"
        //testObject.saveInBackgroundWithBlock(nil)
        
        //println("yo what's good")
        
        //let testObject = PFObject(className: "TestObject")
        //testObject["foo"] = "bar"
        //testObject.objectForKey("foo")
        //testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            //println("Object has been saved.")
        //}
        
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.textField.delegate = self
        
        self.requestMessagesFromParse()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        
    }
    
    func refresh(sender:AnyObject)
    {
        println("successfully inside refresh")
        // Code to refresh table view
        var query = PFQuery(className:"MsgText")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                println("Successfully retrieved \(objects!.count) messages.")
                if let objects = objects as? [PFObject] {
                    var count = 0
                    println(objects.count)
                    println(self.tableViewArray.count)
                    if objects.count != self.tableViewArray.count {
                        //append new objects
                        println("New messages")
                        var currCount = self.tableViewArray.count
                        while currCount < objects.count {
                            let object = objects[currCount]
                            let addText = Message()
                            addText.text = object["text"] as! String
                            self.tableViewArray.append(addText)
                            //println(self.tableViewArray[self.tableViewArray.count])
                            currCount += 1
                        }
                    }
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    func requestMessagesFromParse() {
        // get shit from parse
        // parse into Message objects
        // append to self.tableViewArray
        // call self.tableView.reloadData()
        
        var query = PFQuery(className:"MsgText")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                println("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                        let addText = Message()
                        addText.text = object["text"] as! String
                        self.tableViewArray.append(addText)
                        //println(self.tableViewArray[self.tableViewArray.count])
                    }
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - UITableViewDataSource methods
    
    // create the cells once you have the data
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        var thisMessage = self.tableViewArray[indexPath.row]
        cell.textLabel?.text = thisMessage.text
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK - UITableViewDelegate methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell was tapped at indexPath.row
        
    }

    // send button was tapped - request shit from Parse
    @IBAction func sendButtonTapped(sender: AnyObject) {
        // get shit from Parse
        // send message to parse
        //println("send button tapped")
        
        let messageString = self.textField.text
        let newMessage = Message()
        newMessage.text = messageString
        self.tableViewArray.append(newMessage)
        
        var msg = PFObject(className:"MsgText")
        msg["text"] = self.textField.text
        msg.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                //object saved
            } else {
                //problem
            }
        }
        
        self.textField.text = ""
        self.tableView.reloadData()
        
    }
}



