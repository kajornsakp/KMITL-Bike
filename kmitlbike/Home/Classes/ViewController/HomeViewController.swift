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
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    func setTabBar(){
        self.tabBarController?.tabBarItem.title = "Borrow"
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
                let vc = ViewControllerFactory.sharedInstance.resolve(service: ReturnBikeViewController.self)
                self.present(vc, animated: true, completion: nil)
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
        default:
            return
        }
    }
    
    func showBarcodeScanner(){
        let vc = ViewControllerFactory.sharedInstance.resolve(service: ScanBarcodeViewController.self)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAvailableBike(){
        let vc = ViewControllerFactory.sharedInstance.resolve(service: AvailableBikeViewController.self)
        vc.availableBikeDelegate = self
        let popup = PopupDialog(viewController: vc, buttonAlignment: .vertical, transitionStyle: .bounceUp, gestureDismissal: true, completion: nil)
        self.present(popup, animated: true, completion: nil)
    }
}

extension HomeViewController : AvailableBikeDelegate{
    func didSelectBike(bike: BikeModel) {
        if let bikeMac = bike.bikeMac{
            self.viewModel.currentBike = bike
            self.viewModel.borrowBike(bikeMac: bikeMac)
        }
    }
}

extension HomeViewController : ScanBikeDelegate{
    func onScanBikeSuccess(barcode: String) {
        //self.viewModel.borrowBike(bikeMac: barcode)
        self.navigationController?.popToRootViewController(animated: true)
        let vc = ViewControllerFactory.sharedInstance.resolve(service: ReturnBikeViewController.self)
        self.present(vc, animated: true, completion: nil)
    }
}
extension HomeViewController : BorrowBikeDelegate{
    func onBorrowBikeSuccess(bike : BikeModel) {
        let vc = ViewControllerFactory.sharedInstance.resolve(service: ReturnBikeViewController.self) 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func onBorrowBikeFailed(message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
