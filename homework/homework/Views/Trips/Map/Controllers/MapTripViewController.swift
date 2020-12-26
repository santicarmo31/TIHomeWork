//
//  MapTripViewController.swift
//  homework
//
//  Created by Santiago Carmona on 27/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import UIKit
import MapKit

class MapTripViewController: UIViewController {

    // MARK: - Vars & Constants
    private let mapView: MKMapView = .init()
    private let trip: TruckingTrip

    init(trip: TruckingTrip) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        displayTripLocation()
    }

    override func viewDidLayoutSubviews() {
        mapView.frame = view.frame
    }

    private func displayTripLocation() {
        let startLocation = MKPointAnnotation()
        let endLocation = MKPointAnnotation()
        let locationFrom = trip.truckingOrder.locationFrom
        let locationTo = trip.truckingOrder.locationTo

        startLocation.title = Constants.startLocationTitle
        startLocation.coordinate = CLLocationCoordinate2D(
            latitude: locationFrom.coordinates.latitude,
            longitude: locationFrom.coordinates.longitude
        )

        endLocation.title = Constants.endLocationTitle
        endLocation.coordinate = CLLocationCoordinate2D(
            latitude: locationTo.coordinates.latitude,
            longitude: locationTo.coordinates.longitude
        )

        let annotations = [startLocation, endLocation]
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: true)
    }
}
