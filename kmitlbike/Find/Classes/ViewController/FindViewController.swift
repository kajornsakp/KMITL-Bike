//
//  FindViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/14/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import GoogleMaps

class FindViewController: BaseViewController {

    @IBOutlet weak var mapView : GMSMapView!
    var viewModel : FindViewModel!
    var camera : GMSCameraPosition!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FindViewModel(delegate : self)
        self.initMap()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewModel.getAvailableBike()
        self.setupTitle(title: "Find")
    }

    
    override func onDataDidLoad() {
        self.updateMap()
    }
    func initMap(){
        self.camera = GMSCameraPosition.camera(withLatitude: IC_LATITUTE,
                                               longitude: IC_LONGITUTE, zoom: 16)
        self.mapView.camera = self.camera
        self.mapView.settings.myLocationButton = true
        self.mapView.isMyLocationEnabled = true
        self.mapView.delegate = self
        
    }
    
    func updateMap(){
        self.mapView.clear()
        self.viewModel.bikeList.map {
            let lat = Double($0.currentLat!)
            let long = Double($0.currentLong!)
            let postion : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, long!)
            let marker = GMSMarker(position: postion)
            marker.icon = #imageLiteral(resourceName: "kmitlbike_history_start_marker")
            marker.title = $0.bikeName
            marker.map = self.mapView
        }
    }
    
    
}

extension FindViewController : GMSMapViewDelegate{
    
}
