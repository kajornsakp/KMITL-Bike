//
//  BaseViewModelProtocol.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/15/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit


public protocol BaseViewModelDelegate : class{
    
    //var currentViewController: UIViewController { get }
    
    // Load data
    
    func onDataDidLoad()
    func onDataDidLoadErrorWithMessage(errorMessage:String)
    
    // Navigation Controller
    
    //func pushViewController(viewController: UIViewController, animated: Bool)
    
    // Loading
 
}
