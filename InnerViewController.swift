//
//  InnerViewController.swift
//  Note
//
//  Created by Yasmine Ashraf on 06/08/2021.
//

import UIKit
import CoreLocation

class InnerViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleOutlet: UITextField!
    @IBOutlet weak var detailsOutlet: UITextView!
    @IBOutlet weak var locationLabel: UILabel!

    var innerViewControllerDelegate: InnerViewControllerDelegate?
    let locationManager = CLLocationManager()
    var passedTitle = ""
    var passedDetails = ""
    var thisAddress = "" {
        didSet {
            locationLabel?.text = thisAddress
        }
    }
    var thisDate = ""
    var isNew = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        if isNew{
            thisAddress = getCurrentLoc()
            thisDate = getCurrentDate()
        }
        locationLabel.text = thisAddress
        timeLabel.text = thisDate
        titleOutlet.text = passedTitle
        detailsOutlet.text = passedDetails
    }

    @IBAction func cancelClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveClicked(_ sender: UIBarButtonItem) {
        if let finalTitle = titleOutlet.text, let finalDetails = detailsOutlet.text{
            innerViewControllerDelegate?.passNote(finalTitle, finalDetails, thisAddress, thisDate)
        }
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func drag(_ sender: UIPanGestureRecognizer) {
        detailsOutlet.resignFirstResponder()
        titleOutlet.resignFirstResponder()

    }
    @IBAction func deleteSelected(_ sender: UIBarButtonItem) {
            innerViewControllerDelegate?.deleteNote()
        self.navigationController?.popViewController(animated: true)

    }
    
    
    @IBAction func dragTitle(_ sender: UIPanGestureRecognizer) {
        titleOutlet.resignFirstResponder()

    }
    @IBAction func returnFromTitle(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            print("Location not enabled")
            return
        }
    }
    func getAddressFromLatLon(_ pdblLatitude:String, _ pdblLongitude:String){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        let lon: Double = Double("\(pdblLongitude)")!
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error) in
            if (error != nil){
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            if pm.count > 0 {
                let pm = placemarks![0]
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString += pm.subLocality! + ", "
                }
                if pm.locality != nil {
                    addressString += pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString += pm.country!
                }
                self.thisAddress = addressString
                print(self.thisAddress)
            }
        })
        }
    
    func getCurrentLoc() -> String{
        let coordinates = locationManager.location?.coordinate
        if let lat = coordinates?.latitude, let long = coordinates?.longitude{
            getAddressFromLatLon(String(lat), String(long))
            return thisAddress
        }
        return "failed to get loc"
    }
    func getCurrentDate() -> String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: now)
    }
}
protocol InnerViewControllerDelegate {
    func passNote(_ finalTitle:String, _ finalDetails:String, _ loc:String, _ date:String)
    func deleteNote()
}
