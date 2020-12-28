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
    private enum Metrics {
        static let mapPadding: CGFloat = 30
    }

    private let locationAdapter: LocationAdapter = .init()
    private let mapView: MKMapView = .init()
    private let manager: CLLocationManager = .init()
    private let trip: TruckingTrip
    private let userAnnotation = MKPointAnnotation()

    init(trip: TruckingTrip) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationAdapter.updatedLocation = { [weak self] location in
            self?.userAnnotation.coordinate = location.coordinate
        }
        setupMapView()
        displayTripLocation()
    }

    override func viewDidLayoutSubviews() {
        mapView.frame = view.frame
    }

    private func setupMapView() {
        view.addSubview(mapView)
        mapView.showsUserLocation = true
        mapView.delegate = self
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
        mapView.showAnnotations(annotations, animated: true)
    }

    private func zoomMapToFitAnnotations(_ annotations: [MKAnnotation]) {
        var zoomRect = MKMapRect.null
        for annotation in annotations {
            let point = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: point.x, y: point.y, width: 0, height: 0)
            zoomRect = zoomRect.union(pointRect)
        }
        mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: Metrics.mapPadding, left: Metrics.mapPadding, bottom: Metrics.mapPadding, right: Metrics.mapPadding), animated: true)
    }
}

extension MapTripViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {
            return
        }
        
        guard locationAdapter.authorizationStatus == .authorizedWhenInUse  else {
            let alert = UIAlertController(title: "Attention", message: "We need your location to display how far you are from the tapped location", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        zoomMapToFitAnnotations([annotation, userAnnotation])
    }
}
