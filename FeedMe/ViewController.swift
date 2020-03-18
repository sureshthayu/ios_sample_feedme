//
//  ViewController.swift
//  FeedMe
//
//  Created by Suresh Kumar Thayumanavan on 09/03/20.
//  Copyright © 2020 Suresh Kumar Thayumanavan. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    let locationManager = CLLocationManager()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        // Do any additional setup after loading the view.

        // 1
        locationManager.delegate = self

        // 2
        if CLLocationManager.locationServicesEnabled() {
          // 3
          locationManager.requestLocation()

          // 4
          mapView.isMyLocationEnabled = true
          mapView.settings.myLocationButton = true
        } else {
          // 5
          locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
}


// MARK: - CLLocationManagerDelegate
//1
extension ViewController: CLLocationManagerDelegate {
  // 2
  func locationManager(
    _ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus
  ) {
    // 3
    guard status == .authorizedWhenInUse else {
      return
    }
    // 4
    locationManager.requestLocation()

    //5
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
  }

  // 6
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }

    // 7
    mapView.camera = GMSCameraPosition(
      target: location.coordinate,
      zoom: 15,
      bearing: 0,
      viewingAngle: 0)
  }

  // 8
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
      // 1
      let geocoder = GMSGeocoder()

      // 2
      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        guard
          let address = response?.firstResult(),
          let lines = address.lines
          else {
            return
        }

        // 3
        self.addressLabel.text = lines.joined(separator: "\n")
        
        // 4
        UIView.animate(withDuration: 0.25) {
          self.view.layoutIfNeeded()
        }
      }
    }
    
    
}

extension ViewController: GMSMapViewDelegate {
    
func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
  reverseGeocode(coordinate: position.target)
}

}
