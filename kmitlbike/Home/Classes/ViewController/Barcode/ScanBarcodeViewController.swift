//
//  ScanBarcodeViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/25/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import AVFoundation
import PermissionScope
import RSBarcodes_Swift
import PopupDialog

protocol ScanBikeDelegate : class{
    func onScanBikeSuccess(barcode : String)
}
class ScanBarcodeViewController: RSCodeReaderViewController {

    var barcode: String?
    var dispatched: Bool = false
    var isScanned : Bool = false
    weak var delegate : ScanBikeDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkPermission()
        self.dispatched = false
    }
    
    func checkPermission(){
        switch(PermissionScope().statusCamera()){
        case .unknown:
            PermissionScope().requestCamera()
        case .disabled,.unauthorized:
            let popup = PopupDialog(title: "Permission Required", message: "Please allow KMITL Bike to access camera")
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
            self.styleScan()
            self.startScan()
            
            return
        }
        
    }
    
    func styleScan() {
        let types = NSMutableArray(array: self.output.availableMetadataObjectTypes)
        types.remove(AVMetadataObjectTypeQRCode)
        
        self.output.metadataObjectTypes = NSArray(array: types) as [AnyObject]
        for subview in self.view.subviews {
            self.view.bringSubview(toFront: subview)
        }
        self.focusMarkLayer.strokeColor = UIColor.red.cgColor
        self.cornersLayer.strokeColor = UIColor.green.cgColor
        
    }
    func startScan() {
        self.barcodesHandler = { barcodes in
            if !self.dispatched {
                self.dispatched = true
                for barcode in barcodes {
                    if(self.isScanned){
                        break
                    }
                    self.barcode = barcode.stringValue
                    self.dispatched = false
                    self.isScanned = true
                    self.session.stopRunning()
                    self.borrowBike(withBarcode : self.barcode!)
                    break
                }
            }
        }
    }

    func borrowBike(withBarcode barcode : String){
        if(self.isScanned){
            DispatchQueue.main.sync {
                self.delegate.onScanBikeSuccess(barcode: barcode)
            }
        }
    }
    
}
