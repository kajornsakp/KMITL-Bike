//
//  BaseViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/15/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var isKeyboardAppear = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNotification()
        self.setNavigationBar()
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = KmitlColor.LightMainGreenColor.color()
        self.navigationController?.navigationBar.tintColor = KmitlColor.White.color()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : KmitlColor.White.color()]
    }
    
    func setupTitle(title : String){
        self.navigationItem.title = title
    }
    
    func setTapGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    func setNotification(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if isKeyboardAppear{
            return
        }
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
            self.isKeyboardAppear = true
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        if !isKeyboardAppear {
            return
        }
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y += keyboardSize.height
            self.isKeyboardAppear = false
        }
    }
    
}



extension BaseViewController : BaseViewModelDelegate{
    
        
    public func onDataDidLoad() {
        
    }
    
    public func onDataDidLoadErrorWithMessage(errorMessage: String) {
        
    }
}
