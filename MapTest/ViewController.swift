//
//  ViewController.swift
//  MapTest
//
//  Created by Amish Tyagi on 3/12/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let xCoords : [Double] = [37.8643155328842, 37.80969331740271, 37.68545249143517, 38.35917761445958, 38.364776697550155, 39.74268837876281, 39.77141614260917, 37.767104379369684, 37.78089465405879, 37.730150703568064, 37.75576453031817, 37.78107207045031, 38.682432535034394, 38.65311446143834, 38.733876315963876, 36.81873223408725, 39.21692837754646, 38.40653138277276, 38.6648584877285, 38.62625353216815, 37.98129077800031, 37.87772105025432, 38.92941451102575, 38.76238295406976, 37.32801112003059, 37.32792580673353, 37.30442666008834, 37.66818570124452, 38.30172004884736, 36.590358289706735, 37.48924666568776, 34.43607014675533, 36.98297032780705, 38.460990004403286, 34.15207628984352, 33.930159161875594, 34.116721822465976, 34.206564222717766, 34.148993655295435, 34.0300097100938, 33.05395966963791, 33.35783535859215]
    let yCoords : [Double] = [-122.2687780405056, -122.2579623759987, -122.07184810483834, -120.78919128944116, -120.81808141830888, -121.84873489496785, -121.83676638942414, -122.39378347600007, -122.46382034716433, -122.50138986250748, -122.40645151832979, -122.46378034531669, -121.16362213179175, -121.12347857123692, -120.80279037596678, -119.78081817418443, -121.06530727225487, -121.40202771830750, -121.17803861460341, -121.38864401829989, -122.02244491647446, -122.08461871647803, -121.08175558945392, -121.30865376062431, -121.93846473368569, -121.93837890300274, -120.48205547416818, -121.02083542997909, -122.29277008762807, -121.89203193270808, -122.23262847416197, -119.81472604542556, -122.00793294534361, -122.72204244529333, -118.82966306077583, -118.15876293933740, -118.11627758961218, -118.22410751844488, -118.14771994543443, -118.47814224543815, -117.28485526052849, -117.23031251847067]
    let names = ["Alta Bates Summit Medical Center- Brain Injury Life Skills Support Group", "Oakland Peripheral Neuropathy Support Group", "Neuropathy Support Group", "National Alliance on Mental Illness Amador Connection Recovery Support Group", "Amador County Behavioral Health", "Enloe Conference Center Mental Illness Support Groups", "Parkinson’s Support Group", "Multiple Sclerosis Support Group", "Living with Neuropathy Support Group", "Family Member Support Group", "San Francisco General Hospital BASIC Support Group", "Neuropathy Support Group", "Parkinson’s Support Group", "Parkinson’s Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Association Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Neuropathy Support Group", "Mental Health Support Group", "Parkinson’s Support Group San Marino", "Parkinsons Support Group", "Pasadena Parkinson’s Support Group", "Pituitary Disorders Patient Support Group", "Parkinson’s Support Group", "Parkinson’s Support Group"]
    let county = ["Alameda", "Alameda", "Alameda", "Amador", "Amador", "Butte", "Butte", "San Francisco", "San Francisco", "San Francisco", "San Francisco", "San Francisco", "El Dorado", "El Dorado", "El Dorado", "Fresno", "Nevada", "Sacramento", "Sacramento", "Sacramento", "Contra Costa", "Contra Costa", "Placer", "Placer", "Santa Clara", "Santa Clara", "Merced", "Stanislaus", "Napa", "Monterey", "San Mateo", "Santa Barbara", "Santa Cruz", "Sonoma", "Los Angeles", "Los Angeles", "Los Angeles", "Los Angeles", "Los Angeles", "Los Angeles", "San Diego", "San Diego"]
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    var longitude : Double = 0.0
    var latitude : Double = 0.0
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
//            print("\(latitude) \(longitude)")
//            latitudeLabel.text = "\(latitude)"
//            longitudeLabel.text = "\(longitude)"
            let index = findMinDistance()
            latitudeLabel.text = "The closest support group is the \(names[index]) in \(county[index]) county. Would you like to go there?"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func calculateDistance(index : Int) -> Double{
        let coord1 = CLLocation(latitude: latitude, longitude: longitude)
        let coord2 = CLLocation(latitude: xCoords[index], longitude: yCoords[index])
        print("(\(latitude), \(yCoords[index])), (\(longitude), \(xCoords[index]))")
        print(coord1.distance(from: coord2))
        return coord1.distance(from: coord2)
    }
    func findMinDistance() -> Int {
        var min : Double = 10000000000.0
        var index = -1;
        for i in 0...xCoords.count-1 {
//            print(calculateDistance(index: i));
            if (calculateDistance(index: i) < min) {
                min = calculateDistance(index: i)
                index = i
            }
        }
//        print(index)
        return index;
    }
}

