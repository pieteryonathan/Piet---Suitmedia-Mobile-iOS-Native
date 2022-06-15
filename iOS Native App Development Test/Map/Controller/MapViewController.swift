//
//  MapViewController.swift
//  iOS Native App Development Test
//
//  Created by Pieter Yonathan on 13/06/22.
//

import UIKit
import MapKit

protocol MapViewControllerPop{
    func userInfoForBottom(userData: UserData)
}

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var infoUser: [UserInfoMap] = []
//    init(infoUser: [UserInfoMap]){
//        self.infoUser = infoUser
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    var delegate: MapViewControllerDelegateBottom?
    var delegate: MapViewControllerPop?
    let bottomSheetViewController = BottomSheetViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMultiplePin()
        setup()
        print(infoUser)
    }
    
    func setup(){
        mapView.delegate = self
        let suitmediaCoordinate = CLLocationCoordinate2D(latitude: -6.276254446787058, longitude: 106.8246424837679)
        let region = MKCoordinateRegion(center: suitmediaCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        bottomSheetViewController.delegatePop=self
        
    }
    
    func addMultiplePin(){
//       let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: -6.276254446787058, longitude: 106.8246424837679)
//        mapView.addAnnotation(annotation)
        
        for location in infoUser {
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2D(latitude: location.annotation.latitude ?? 0, longitude: location.annotation.longitude ?? 0)
            pin.title = location.annotation.title
            pin.subtitle = location.annotation.subtitle
            mapView.addAnnotation(pin)
        }
    }
    
    
    //Custom Pin Point
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named:"ic_pin_point")
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        for data in infoUser{
            if data.annotation.longitude == annotation?.coordinate.longitude && data.annotation.latitude == annotation?.coordinate.latitude{
                let bottomSheetViewController = BottomSheetViewController(userInfo: data)
                let navVC = UINavigationController(rootViewController: bottomSheetViewController)
                navVC.modalPresentationStyle = .overCurrentContext
                present(navVC, animated: true)
            }
        }
//        print(view)

    }
    
    
}

extension MapViewController: UserViewControllerDelegateMap{
    func getDataUserForMap(userData: [UserInfoMap]) {
        infoUser = userData
    }
}

extension MapViewController: BottomSheetPop{
    func getDataUserPop(userData: UserData) {
        navigationController?.popViewController(animated: true)
    }
}
