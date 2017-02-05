//
//  ReturnMapViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/30/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import GoogleMaps

class ReturnMapViewController: BaseViewController {

    @IBOutlet weak var mapView : GMSMapView!
    var camera : GMSCameraPosition!
    var mapRoute : [CLLocation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        NotificationCenter.default.setObserver(self, selector: #selector(updateLocation(_:)), name: Notification.Name(rawValue: "com.kajornsak.notificationkey"), object: nil)
        mapRoute = [CLLocation]()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupMap(){
        self.camera = GMSCameraPosition.camera(withLatitude: IC_LATITUTE,
                                               longitude: IC_LONGITUTE, zoom: 16)
        self.mapView.camera = self.camera
        self.mapView.settings.myLocationButton = true
        self.mapView.isMyLocationEnabled = true
        self.mapView.delegate = self
        
    }
    
    func updatePath(){
        mapView.clear()
        let path = GMSMutablePath()
        let _ = mapRoute.map{
            path.add($0.coordinate)
        }
        let polyline = GMSPolyline(path: path)
        polyline.map = mapView
    }
    
    func updateLocation(_ notification : NSNotification){
        if let location = notification.userInfo?["location"] as? CLLocation{
            self.mapRoute.append(location)
            self.updatePath()
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "com.kajornsak.notificationkey"), object: nil)
    }
}

extension ReturnMapViewController : GMSMapViewDelegate{
    
}


