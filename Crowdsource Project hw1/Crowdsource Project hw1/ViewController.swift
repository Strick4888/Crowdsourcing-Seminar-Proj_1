//
//  ViewController.swift
//  Crowdsource Project hw1
//
//  Created by Benjamin Strick on 9/24/15.
//  Copyright (c) 2015 Benjamin Strick. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {


    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var tableViewArray:[Message] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let testObject:PFObject = PFObject(className: "TestClass")
        //testObject["SomeProperty"] = "SomeValue"
        //testObject.saveInBackgroundWithBlock(nil)
        
        println("yo what's good")
        
        
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.textField.delegate = self
        
        self.requestMessagesFromParse()
        
    }
    
    func requestMessagesFromParse() {
        // get shit from parse
        // parse into Message objects
        // append to self.tableViewArray
        // call self.tableView.reloadData()
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
        self.textField.text = ""
        
        
        
        self.tableView.reloadData()
        
    }
}

