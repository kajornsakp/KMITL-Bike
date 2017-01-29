//
//  ViewControllerFactory.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 12/2/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation
import Swinject

private struct Storyboard {
    static let login = "Login"
    static let home = "Home"
    static let history = "History"
    static let more = "More"
    static let borrow = "Borrow"
    static let barcode = "Barcode"
    static let returnBike = "Return"
}

class ViewControllerFactory: BaseFactory
{
    static let sharedInstance = ViewControllerFactory()
    
    override init() {
        super.init()
    }
    
    internal override func setup() {
        loginViewController()
        signupViewController()
        homeViewController()
        historySummaryViewController()
        creditViewController()
        tutorialPopupViewController()
        availableBikeViewController()
        scanBarcodeViewController()
        returnBikeViewController()
    }
    
    // MARK:
    // MARK: Organize methods in alphabetical order
    
    private func loginViewController(){
        container.register(LoginViewController.self){
            _ in
            let storyboard = UIStoryboard(name : Storyboard.login,bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: LoginViewController.className) as! LoginViewController
            return vc
        }
    }
    private func signupViewController(){
        container.register(SignUpViewController.self){
            _ in
            let storyboard = UIStoryboard(name : Storyboard.login,bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier : SignUpViewController.className) as! SignUpViewController
            return vc
        }
    }
    private func homeViewController(){
        container.register(HomeViewController.self){
            _ in
            let storyboard = UIStoryboard(name : Storyboard.home,bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: HomeViewController.TAB_BAR_CONTROLLER_IDENTIFIER) as! HomeViewController
            return vc
        }
    }
    private func historySummaryViewController(){
        container.register(HistorySummaryViewController.self){
            _ in
            let storyboard = UIStoryboard(name: Storyboard.history, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: HistorySummaryViewController.className) as! HistorySummaryViewController
            return vc
        }
    }
    private func creditViewController(){
        container.register(CreditViewController.self){
            _ in
            let storyboard = UIStoryboard(name: Storyboard.more, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: CreditViewController.className) as! CreditViewController
            return vc
        }
    }
    private func tutorialPopupViewController(){
        container.register(TutorialPopupViewController.self){
            _ in
            let storyboard = UIStoryboard(name: Storyboard.borrow, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: TutorialPopupViewController.className) as! TutorialPopupViewController
            return vc
        }
    }
    private func availableBikeViewController(){
        container.register(AvailableBikeViewController.self){
            _ in
            let storyboard = UIStoryboard(name: Storyboard.borrow, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: AvailableBikeViewController.className) as! AvailableBikeViewController
            return vc
        }
    }
    private func scanBarcodeViewController(){
        container.register(ScanBarcodeViewController.self){
            _ in
            let storyboard = UIStoryboard(name: Storyboard.barcode, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ScanBarcodeViewController.className) as! ScanBarcodeViewController
            return vc
        }
    }
    private func returnBikeViewController(){
        container.register(ReturnBikeViewController.self){
            _ in
            let storyboard = UIStoryboard(name: Storyboard.returnBike, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ReturnBikeViewController.className) as! ReturnBikeViewController
            return vc
        }
    }
}
