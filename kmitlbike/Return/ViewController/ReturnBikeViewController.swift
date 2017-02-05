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
        viewModel.locationDelegate = self
        viewModel.setupLocationManager()
    }
    func setupNotification(){
        NotificationCenter.default.setObserver(self, selector: #selector(dismissBikeViewController), name: Notification.Name(rawValue: ReturnButtonViewController.DISMISS_NOTIFICATION_KEY), object: nil)
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
        print(self.ridingBikeModel.borrowTime)
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
    
    func dismissBikeViewController(){
        self.viewModel.locationManager.stopUpdatingLocation()
        self.dismiss(animated: true, completion: nil)
    }

}

extension ReturnBikeViewController : BikeMapDelegate{
    func onMapDidUpdate(location: CLLocation) {
        let locationDict : [String : CLLocation] = ["location":location]
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKey), object: self,userInfo: locationDict)
    }
}
