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


class ReturnBikeViewController: BaseViewController {

    @IBOutlet weak var bikeCodeLabel : UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var switchViewButton: UIButton!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    var disposeBag = DisposeBag()
    var isMapViewShown : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRxButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    func setupUI(){
        
    }
    func setupRxButton(){
        self.switchViewButton.rx.tap.map{ _ in
            self.isMapViewShown = !(self.isMapViewShown)
            self.setButtonText()
            self.replaceContainerView()
        }.subscribe()
        .addDisposableTo(disposeBag)
        
        
    }
    
    func setButtonText(){
        if(isMapViewShown){
            self.switchViewButton.setTitle("Switch to Return bike", for: .normal)
        }else{
            self.switchViewButton.setTitle("Switch to Map view", for: .normal)
        }
    }
    func replaceContainerView(){
        if(isMapViewShown){
            self.containerView.backgroundColor = KmitlColor.Green.color()
        }else{
            self.containerView.backgroundColor = KmitlColor.Orange.color()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
