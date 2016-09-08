//
//  EmailViewController.swift
//  notulen
//
//  Created by Agust Lofianto on 8/31/16.
//  Copyright © 2016 xiang. All rights reserved.
//

import UIKit
import MessageUI

class EmailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var txtSendTo: UITextField!
    @IBOutlet weak var txtCcTo: UITextField!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var lists: ListItem = ListItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: (#selector(ViewController.keyboardWillShow(_:))), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: (#selector(ViewController.keyboardWillHide(_:))), name: UIKeyboardWillHideNotification, object: nil)
        
        //print(lists)
        txtSendTo.keyboardType = UIKeyboardType.EmailAddress
        txtCcTo.keyboardType = UIKeyboardType.EmailAddress
        textArea.text = lists.rowItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerViewController = MFMailComposeViewController()
        mailComposerViewController.mailComposeDelegate = self
        
        mailComposerViewController.setToRecipients(txtSendTo.text?.componentsSeparatedByString(","))
        mailComposerViewController.setCcRecipients(txtCcTo.text?.componentsSeparatedByString(","))
        mailComposerViewController.setSubject(txtSubject.text!)
        mailComposerViewController.setMessageBody(textArea.text!, isHTML: false)
        
        return mailComposerViewController
    }
    
    func showSendMailErrorAlert() {
        let titleAlert: String = "Could Not Send Email"
        let titleMsg: String = "Your device could not send e-mail. Please check your e-mail configuration and try again."
        
        let sendMailErrorAlert = UIAlertController(title: titleAlert, message: titleMsg, preferredStyle: UIAlertControllerStyle.Alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
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
            self.bottomConstraint.constant = 20
        })
    }
    
    @IBAction func btnSendEmail(sender: UIButton) {
        let mailComposeVieController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeVieController, animated: true, completion: nil)
        }
        else {
            self.showSendMailErrorAlert()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
