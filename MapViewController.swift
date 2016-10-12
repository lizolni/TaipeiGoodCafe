//
//  MapViewController.swift
//  
//
//  Created by Allen on 2016/10/10.
//
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    var getStoreLatitude : String!
    var getStoreLongtitude : String!
    var getStoreNameForMap :String!
    
    let locationManager:CLLocationManager = CLLocationManager()
    

    @IBOutlet weak var storeMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("long \(getStoreLongtitude)")
        print("lat \(getStoreLatitude)")

        //Navigation Bar title name
        self.title = "\(getStoreNameForMap)"

        //設定delegate
        locationManager.delegate = self

        //set Delegate
        storeMap.delegate = self

        //使用者確認同意使用地圖
        locationManager.requestAlwaysAuthorization()

        //設定目的地資訊
        // setting End Point
        let destinationlocation = CLLocationCoordinate2D(
            latitude: Double(getStoreLatitude)! ,
            longitude: Double(getStoreLongtitude)!
        )
        
        //set Placemark
        let destinationPlacemark = MKPlacemark(coordinate: destinationlocation, addressDictionary: nil)
        //set MapItem
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        //set destination Annotation
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Destination"
        destinationAnnotation.subtitle = "\(getStoreNameForMap)"

        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
            print(location)
        }
        //set destination的圖釘
        self.storeMap.showAnnotations([destinationPlacemark], animated: true)
        

        //在地圖上加上路徑
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem.mapItemForCurrentLocation()
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .Automobile

        let directions = MKDirections(request: directionRequest)
        print("directions \(directions)")

        //判斷規畫地圖是否正確?

        directions.calculateDirectionsWithCompletionHandler{ (response,error)-> Void in
    
            guard let response = response else {
                if let error = error {
                    print("Error \(error)")
                }
                return
            }
        //規劃路線圖 & 使用addOverlay方法，將顏色物件加在路線上
    
            let route = response.routes[0]
    
            self.storeMap.addOverlay((route.polyline),level: MKOverlayLevel.AboveLabels)
    
            let rect = route.polyline.boundingMapRect
    
            self.storeMap.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)

        }
    }
 //viewDidLoad End

    //控制畫路徑圖的程式 -> overlay

    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    
        let renderer = MKPolylineRenderer(overlay: overlay)
    
        renderer.strokeColor = UIColor.redColor().colorWithAlphaComponent(0.5)
    
        renderer.lineWidth = 5.0
    
        return renderer

    }

    // 取得使用者位置

    func locationManager(manager:CLLocationManager!, CLLocationManagerDelegate status:CLAuthorizationStatus){
        storeMap.showsUserLocation = (status == .AuthorizedAlways)
    }

}

