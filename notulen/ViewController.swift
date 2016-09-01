//
//  ViewController.swift
//  notulen
//
//  Created by Agust Lofianto on 3/31/16.
//  Copyright © 2016 xiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemText: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    let reuseIdentifier = "cell"
    let emailSegueIdentifier = "showEmailSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: (#selector(ViewController.keyboardWillShow(_:))), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: (#selector(ViewController.keyboardWillHide(_:))), name: UIKeyboardWillHideNotification, object: nil)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == emailSegueIdentifier {
            let destination = segue.destinationViewController as! EmailViewController
            destination.lists = lists
        }
    }

    @IBAction func btnAddItem(sender: UIButton) {
        if (itemText.text == "") {
            //if blank, do not add a record
        } else {
            //add record
            lists.addItem(itemText.text!)
            print(itemText.text!)
            print(lists.items)
            //dismiss keyboard and reset field
            self.view.endEditing(true)
            itemText.text = nil
            tableView.reloadData()
        }
    }
    
    @IBAction func btnClear(sender: UIBarButtonItem) {
        lists.delete()
        tableView.reloadData()
    }
    
    
    @IBAction func btnSendEmail(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier(emailSegueIdentifier, sender: sender)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        itemText.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillHide(sender: NSNotification) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomConstraint.constant = 8
        })
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            lists.items.removeAtIndex(indexPath.row)
            tableView.reloadData()
            print(lists.items)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.items.count
    }
    
    func tableView(tablieView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        //var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        //if(cell2 == nil) {
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel?.sizeToFit()
        cell.textLabel?.numberOfLines = 0
        //}
        cell.textLabel?.text = lists.items[indexPath.row].desc
        return cell
        
        /*
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell;
        if(cell == nil)
        {
        cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier: "CELL")
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        cell?.textLabel.font = UIFont.systemFontOfSize(15.0)
        cell?.textLabel.sizeToFit()
        cell?.textLabel.text = messageArray[indexPath.row]
        cell?.textLabel.numberOfLines = 0
        return cell!;
        */
    }
    
}

