//
//  AnnotationPin.swift
//  iOS Native App Development Test
//
//  Created by Pieter Yonathan on 13/06/22.
//

import Foundation
import MapKit

struct UserInfoMap{
    var website = "https://suitmedia.com/"
    var email: String?
    var first_name: String?
    var last_name: String?
    var avatar: String?
    var annotation: AnnotationPin
}

struct AnnotationPin{
    var title: String?
    var subtitle: String?
    var latitude: Double?
    var longitude: Double?
}

struct PinPoint{
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D?
}
