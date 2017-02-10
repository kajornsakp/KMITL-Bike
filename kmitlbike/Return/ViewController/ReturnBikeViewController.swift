//
//  ReturnBikeViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/25/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMaps
import SVProgressHUD

class ReturnBikeViewController: BaseViewController {

    @IBOutlet weak var bikeCodeLabel : UILabel!
    @IBOutlet weak var switchViewButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var ridingBikeModel : RidingBikeModel!
    let notificationKey = "com.kajornsak.notificationkey"
    var disposeBag = DisposeBag()
    var isMapViewShown : Bool = false
    var buttonVC : ReturnButtonViewController!
    var mapVC : ReturnMapViewController!
    var viewModel : ReturnBikeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ReturnBikeViewModel(delegate: self)
        setupVC()
        setupRxButton()
        setupNotification()
        setupUI()
        viewModel.bikeModel = self.ridingBikeModel
        viewModel.timerDelegate = self
        viewModel.locationDelegate = self
        viewModel.setupLocationManager()
        viewModel.setupSecTimer()
        viewModel.setupUpdateTimer()
    }
    func setupNotification(){
        NotificationCenter.default.setObserver(self, selector: #selector(callReturnBike), name: Notification.Name(rawValue: ReturnButtonViewController.DISMISS_NOTIFICATION_KEY), object: nil)
    }
    
    func setupVC(){
        buttonVC = ViewControllerFactory.sharedInstance.resolve(service: ReturnButtonViewController.self)
        mapVC = ViewControllerFactory.sharedInstance.resolve(service: ReturnMapViewController.self)
        self.addChildViewController(buttonVC)
        self.addChildViewController(mapVC)
        buttonVC.view.frame = CGRect(x: 0, y: 0, width: containerView.bounds.width, height: containerView.bounds.height)
        mapVC.view.frame = CGRect(x: 0, y: 0, width: containerView.bounds.width, height: containerView.bounds.height)
        mapVC.view.isHidden = !isMapViewShown
        self.containerView.addSubview(buttonVC.view)
        self.containerView.addSubview(mapVC.view)
        
    }
    
    func setupUI(){
        self.bikeCodeLabel.text = "Code : \(self.ridingBikeModel.passcode!)"
    }
    
    func setupRxButton(){
        self.switchViewButton.rx.tap.map{ _ in
            self.isMapViewShown = !(self.isMapViewShown)
            self.switchView()
        }.subscribe()
        .addDisposableTo(disposeBag)
    }
    
    func switchView(){
        if(isMapViewShown){
            self.switchViewButton.setTitle("Switch to Return bike", for: .normal)
        }else{
            self.switchViewButton.setTitle("Switch to Map view", for: .normal)
        }
        replaceContainerView()
    }
    func replaceContainerView(){
        if(isMapViewShown){
           buttonVC.view.isHidden = true
            mapVC.view.isHidden = false
        }else{
            buttonVC.view.isHidden = false
            mapVC.view.isHidden = true
        }
    }
    
//    func callReturnBike(){
//        self.viewModel.stopUpdating()
//        self.dismiss(animated: true, completion: nil)
//    }
    
    func callReturnBike(){
        let vc = ViewControllerFactory.sharedInstance.resolve(service: ScanBarcodeViewController.self)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    func updateDistanceDisplay(){
        self.distanceLabel.text = String(self.viewModel.distanceAmount)
    }
    override func onDataDidLoad() {
        self.viewModel.stopUpdating()
        self.dismiss(animated: true, completion: nil)
    }
    override func onDataDidLoadErrorWithMessage(errorMessage: String) {
        SVProgressHUD.showError(withStatus: errorMessage)
    }
}
extension ReturnBikeViewController : ScanBikeDelegate{
    func onScanBikeSuccess(barcode: String) {
        self.dismiss(animated: true, completion: nil)
        self.viewModel.returnBike(withBarcode: barcode)
    }
}
extension ReturnBikeViewController : BikeMapDelegate{
    func onMapDidUpdate(location: CLLocation) {
        let locationDict : [String : CLLocation] = ["location":location]
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKey), object: self,userInfo: locationDict)
        updateDistanceDisplay()
    }
    
}

extension ReturnBikeViewController : BikeTimerDelegate{
    func onSecUpdate() {
        self.durationLabel.text = self.viewModel.secAmount.toTimeString()
    }
}
