//
//  HomeViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 12/25/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import PopupDialog
import PermissionScope
import SVProgressHUD
class HomeViewController: BaseViewController {
    static let TAB_BAR_CONTROLLER_IDENTIFIER = "MainTabBarController"
    var viewModel : HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(delegate: self)
        viewModel.borrowBikeDelegate = self
        self.setTabBar()
        self.setupTitle(title: "Borrow Bike")
        viewModel.getStatus()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func setTabBar(){
        self.tabBarController?.tabBarItem.title = "Borrow"
        self.tabBarController?.tabBar.tintColor = KmitlColor.LightMainGreenColor.color()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBorrowBikeClick(_ sender: Any) {
        showTutorial()
    }
    
    func showTutorial(){
        let vc = ViewControllerFactory.sharedInstance.resolve(service: TutorialPopupViewController.self)
        let popup = PopupDialog(viewController: vc, buttonAlignment: .vertical, transitionStyle: .bounceUp, gestureDismissal: true, completion: nil)
        let buttonOne = DefaultButton(title: "NEXT") {
            if(Developer.ENABLED){
//                let vc = ViewControllerFactory.sharedInstance.resolve(service: ReturnBikeViewController.self)
//                let ridingBike = RidingBikeModel(withBikeMac: "KB010", passcode: "12345", borrowTime: NSDate())
//                vc.ridingBikeModel = ridingBike
//                self.present(vc, animated: true, completion: nil)
                self.checkPermission()
            }
            else{
                self.checkPermission()
            }
        }
        buttonOne.buttonColor = KmitlColor.LightMainGreenColor.color()
        buttonOne.titleColor = KmitlColor.White.color()
        popup.addButton(buttonOne)
        self.present(popup, animated: true, completion: nil)
    }

    func showHowToLock(){
        let vc = ViewControllerFactory.sharedInstance.resolve(service: UnlockBikeCodeViewController.self)
        let popup = PopupDialog(viewController: vc, buttonAlignment: .vertical, transitionStyle: .bounceUp, gestureDismissal: true, completion: nil)
        let buttonNext = DefaultButton(title: "NEXT"){
            
        }
        buttonNext.buttonColor = KmitlColor.LightMainGreenColor.color()
        buttonNext.titleColor = KmitlColor.White.color()
        popup.addButton(buttonNext)
        self.present(popup,animated: true,completion: nil)
    }
    func checkPermission(){
        switch PermissionScope().statusLocationInUse() {
        case .unknown:
            PermissionScope().requestLocationInUse()
        case .unauthorized,.disabled:
            let popup = PopupDialog(title: "Permission Required", message: "Please allow KMITL Bike to access location service")
            let button = DefaultButton(title: "Open Setting"){
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(appSettings as URL)
                    } else {
                        UIApplication.shared.openURL(appSettings)
                    }
                }
            }
            popup.addButton(button)
            self.present(popup,animated: true,completion: nil)
            return
        case .authorized:
            showBarcodeScanner()
            return
        }
    }
    
    func showBarcodeScanner(){
        let vc = ViewControllerFactory.sharedInstance.resolve(service: ScanBarcodeViewController.self)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func onDataDidLoad() {
        if let result = self.viewModel.userStatusResponse.result{
            switch result {
            case "success":
                print("success")
            case "continue":
                self.resumeBikeSession()
            default:
                SVProgressHUD.showError(withStatus: "Failed to connect to server")
            }
        }
    }
    
    func resumeBikeSession(){
        if let session = self.viewModel.userStatusResponse{
            guard let bikeMac = session.bikeMac,let passcode = session.passcode,let routeLine = session.routeLine,let totalTime = session.totalTime,let totalDistance = session.totalDistance else{
                return
            }
            let bikeSession = BikeSessionModel(withBikeMac: bikeMac, passcode: passcode, currentLat: "", currentLong: "", totalTime: totalTime, totalDistance: totalDistance, routeLine: routeLine)
            let routeArray = bikeSession.getRouteLine()
            let vc = ViewControllerFactory.sharedInstance.resolve(service: ReturnBikeViewController.self)
            vc.ridingBikeModel = RidingBikeModel(withBikeMac: bikeSession.bikeMac!, passcode: bikeSession.passcode!, borrowTime: Date() as NSDate, totalTime: 0, totalDistance: Double(0.0), routeLine: routeArray)
            self.present(vc, animated: true, completion: nil)
        }
    }
}


extension HomeViewController : ScanBikeDelegate{
    func onScanBikeSuccess(barcode: String) {
        let _ = self.navigationController?.popToRootViewController(animated: true)
        self.viewModel.borrowBike(barcode: barcode)
    }
}
extension HomeViewController : BorrowBikeDelegate{
    func onBorrowBikeSuccess(passcode : String) {
        SVProgressHUD.dismiss()
        let vc = ViewControllerFactory.sharedInstance.resolve(service: ReturnBikeViewController.self)
        let ridingBike = RidingBikeModel(withBikeMac: passcode, passcode: passcode, borrowTime: NSDate())
        vc.ridingBikeModel = ridingBike
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func onBorrowBikeFailed(message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
