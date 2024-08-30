import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Request location authorization
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func sosButtonTapped(_ sender: UIButton) {
        // Check if the location services are enabled
        if CLLocationManager.locationServicesEnabled() {
            // Check the authorization status
            switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                // Get the user's current location
                locationManager.delegate = self
                locationManager.startUpdatingLocation()
            case .denied, .restricted:
                // Handle the case when the user denied location access or it's restricted
                displayLocationAccessAlert()
            case .notDetermined:
                // Location permission not yet determined
                locationManager.requestWhenInUseAuthorization()
            @unknown default:
                fatalError("Unhandled case for authorizationStatus.")
            }
        } else {
            // Location services are disabled
            displayLocationServicesDisabledAlert()
        }
    }
    
    // Function to display an alert when location access is denied or restricted
    func displayLocationAccessAlert() {
        let alert = UIAlertController(title: "Location Access Denied", message: "Please enable location access for this app in Settings > Privacy > Location Services.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Function to display an alert when location services are disabled
    func displayLocationServicesDisabledAlert() {
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this device in Settings > Privacy > Location Services.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// Extension to handle location updates
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Stop updating location once we get a location
        locationManager.stopUpdatingLocation()
        
        // Get the user's current location from the locations array
        if let location = locations.first {
            // Send the location to the emergency contacts or perform any other actions
            print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location errors here, if any
        print("Location Error: \(error.localizedDescription)")
    }
   
}








