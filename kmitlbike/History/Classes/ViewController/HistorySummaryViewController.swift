//
//  HistorySummaryViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/10/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD
class HistorySummaryViewController: BaseViewController {
    
    @IBOutlet var durationLabel : UILabel!
    @IBOutlet var distanceLabel : UILabel!
    @IBOutlet var bikeNameLabel : UILabel!
    @IBOutlet var borrowTimeLabel : UILabel!
    @IBOutlet var mapView : GMSMapView!
    var camera : GMSCameraPosition!
    var bikeHistory : HistoryModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTitle(title: "Summary")
        self.initUI()
        self.initMap()
        self.drawMap()
        // Do any additional setup after loading the view.
    }

    func initUI(){
        guard let bikeHistory = bikeHistory else {
            self.navigationController?.dismiss(animated: true, completion: nil)
            return
        }
        self.durationLabel.text = bikeHistory.totalTime
        self.distanceLabel.text = bikeHistory.totalDistance
        self.bikeNameLabel.text = bikeHistory.bikeName
        self.borrowTimeLabel.text = bikeHistory.borrowDate! + "-" + bikeHistory.borrowTime!
    }
    func initMap(){
        self.camera = GMSCameraPosition.camera(withLatitude: IC_LATITUTE,
                                                           longitude: IC_LONGITUTE, zoom: 16)
        self.mapView.camera = self.camera
        self.mapView.isMyLocationEnabled = false
        self.mapView.delegate = self
        
    }
    
    func drawMap(){
        if let route = self.bikeHistory.routeLine{
            if route.count == 0 {
                return
            }
            let coordinateArray = route.sorted(by: { (a, b) -> Bool in
                let date = Date(timeIntervalSince1970: a.time!)
                let date2 = Date(timeIntervalSince1970: b.time!)
                return date.compare(date2) == .orderedAscending
            })
            let path = GMSMutablePath()
            let _ = coordinateArray.map{ path.add(CLLocationCoordinate2D(latitude: $0.lat!, longitude: $0.lng!))}
            let polyline = GMSPolyline(path: path)
            let outerPolyline = GMSPolyline(path: path)
            polyline.strokeWidth = 2.5
            outerPolyline.strokeWidth = 5
            polyline.strokeColor = UIColor(netHex: 0x00b3fc)
            outerPolyline.strokeColor = UIColor(netHex: 0x387cc4)
            outerPolyline.map = self.mapView
            polyline.map = self.mapView
            let startPosition = CLLocationCoordinate2DMake(coordinateArray.first!.lat!, coordinateArray.first!.lng!)
            let startMarker = GMSMarker(position: startPosition)
            let goalPosition = CLLocationCoordinate2DMake(coordinateArray.last!.lat!, coordinateArray.last!.lng!)
            let goalMarker = GMSMarker(position: goalPosition)
            startMarker.icon = #imageLiteral(resourceName: "kmitlbike_history_start_marker")
            goalMarker.icon = #imageLiteral(resourceName: "kmitlbike_history_goal_marker")
            startMarker.map = self.mapView
            goalMarker.map = self.mapView
            
            let centerLat = (startPosition.latitude + goalPosition.latitude)/2
            let centerLong = (startPosition.longitude + goalPosition.longitude)/2
            let centerPosition = CLLocationCoordinate2DMake(centerLat, centerLong)
            self.camera = GMSCameraPosition.camera(withTarget: centerPosition, zoom: 16)
            self.mapView.camera = self.camera
        }
    }

}


extension HistorySummaryViewController : GMSMapViewDelegate{
    
}
