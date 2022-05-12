////
////  MapScreen.swift
////  MapKit-Directions
////
////  Created by Sean Allen on 9/1/18.
////  Copyright © 2018 Sean Allen. All rights reserved.
////
//
//import UIKit
//import MapKit
//import CoreLocation
//
//class MapScreen: UIViewController {
//
//    @IBOutlet weak var mapView: MKMapView!
//
//    let locationManager = CLLocationManager()
//    let regionInMeters: Double = 10000
//    var previousLocation: CLLocation?
//    var destination  = CLLocationCoordinate2D()
//    let geoCoder = CLGeocoder()
//    var directionsArray: [MKDirections] = []
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        goButton.layer.cornerRadius = goButton.frame.size.height/2
//        checkLocationServices()
//        getDirections()
//    }
//
//
//    func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//
//    func centerViewOnUserLocation() {
//        if let location = locationManager.location?.coordinate {
//            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//            mapView.setRegion(region, animated: true)
//        }
//    }
//
//
//    func checkLocationServices() {
//        if CLLocationManager.locationServicesEnabled() {
//            setupLocationManager()
//            checkLocationAuthorization()
//        } else {
//            // Show alert letting the user know they have to turn this on.
//        }
//    }
//
//
//    func checkLocationAuthorization() {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//            startTackingUserLocation()
//        case .denied:
//            // Show alert instructing them how to turn on permissions
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            // Show an alert letting them know what's up
//            break
//        case .authorizedAlways:
//            break
//        @unknown default:
//            break
//        }
//    }
//
//
//    func startTackingUserLocation() {
//        mapView.showsUserLocation = true
//        centerViewOnUserLocation()
//        locationManager.startUpdatingLocation()
////        previousLocation = getCenterLocation(for: mapView)
//    }
//
//
////    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
////        let latitude = mapView.centerCoordinate.latitude
////        let longitude = mapView.centerCoordinate.longitude
////
////        return CLLocation(latitude: latitude, longitude: longitude)
////    }
//
//
//    func getDirections() {
//        guard let location = locationManager.location?.coordinate else {
//            //TODO: Inform user we don't have their current location
//            print("yo")
//            return
//        }
//
//        let request = createDirectionsRequest(from: location)
//        let directions = MKDirections(request: request)
//        resetMapView(withNew: directions)
//        print("yo im here wheret tf r the directions")
//        directions.calculate { [unowned self] (response, error) in
//            //TODO: Handle error if needed
////            print("yo im here wheret tf r the directions")
//            guard let response = response else {print("yo im here wheret tf r the directionsssssssss")
//                return } //TODO: Show response not available in an alert
//            for route in response.routes {
//                self.mapView.addOverlay(route.polyline)
//                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//            }
//        }
//    }
//
//
//    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
//        let destinationCoordinate       = destination
//        let startingLocation            = MKPlacemark(coordinate: coordinate)
//        let destination                 = MKPlacemark(coordinate: destinationCoordinate)
//
//        let request                     = MKDirections.Request()
//        request.source                  = MKMapItem(placemark: startingLocation)
//        request.destination             = MKMapItem(placemark: destination)
//        request.transportType           = .automobile
//        request.requestsAlternateRoutes = true
//
//        return request
//    }
//
//
//    func resetMapView(withNew directions: MKDirections) {
//        mapView.removeOverlays(mapView.overlays)
//        directionsArray.append(directions)
//        let _ = directionsArray.map { $0.cancel() }
//    }
//
//
////    @IBAction func goButtonTapped(_ sender: UIButton) {
////        getDirections()
////    }
//}
//
//
//extension MapScreen: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorization()
//    }
//}
//
//
//extension MapScreen: MKMapViewDelegate {
//
////    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
////        let center = getCenterLocation(for: mapView)
////
////        guard let previousLocation = self.previousLocation else { return }
////
////        guard center.distance(from: previousLocation) > 50 else { return }
////        self.previousLocation = center
////
////        geoCoder.cancelGeocode()
////
////
////        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
////            guard let self = self else { return }
////
////            if let _ = error {
////                //TODO: Show alert informing the user
////                return
////            }
////
////            guard let placemark = placemarks?.first else {
////                //TODO: Show alert informing the user
////                return
////            }
////
////            let streetNumber = placemark.subThoroughfare ?? ""
////            let streetName = placemark.thoroughfare ?? ""
////
////            DispatchQueue.main.async {
////                self.addressLabel.text = "\(streetNumber) \(streetName)"
////            }
////        }
////    }
//
//
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
//        renderer.strokeColor = .blue
//
//        return renderer
//    }
//}

import UIKit
import MapKit

class MapScreen2: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var destination  = CLLocationCoordinate2D()
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
//        getDirections()
    }

    @IBAction func goButtonPressed(_ sender: Any) {
        getDirections()
    }
    func getDirections() {
        guard let userLocationCoordinate = UserLocation.shared.location?.coordinate else { return }
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(
            placemark: MKPlacemark(
                coordinate: userLocationCoordinate
            )
        )
        directionRequest.destination = MKMapItem(
            placemark: MKPlacemark(
                coordinate: destination
            )
        )
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            let response = response
            print("hi2")
            let route = response?.routes.first
            if let line = route?.polyline {
                self.mapView.addOverlay(line, level: .aboveRoads)
            }
        }
    }


    //MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyLine = overlay as? MKPolyline {
            let lineRenderer = MKPolylineRenderer(polyline: polyLine)
            lineRenderer.strokeColor = .red
            lineRenderer.lineWidth = 3
            return lineRenderer
        }
        
        return MKOverlayRenderer()
    }

    //MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        UserLocation.shared.location = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            print("yo")
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        case .denied:
            print("hi")
            UserLocation.shared.location = nil
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            print("hi2")
            UserLocation.shared.location = nil
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error -> \(String(describing: error.localizedDescription))")
    }
}
class UserLocation {
    static let shared = UserLocation()
    var location: CLLocation?
}
