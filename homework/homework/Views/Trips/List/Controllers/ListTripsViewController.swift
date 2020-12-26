//
//  ListTripsViewController.swift
//  homework
//
//  Created by Santiago Carmona on 26/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import UIKit

fileprivate enum Section: Int, CaseIterable {
    case trips = 0, empty
}

class ListTripsViewController: UIViewController {
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TruckingTrip>
    private typealias ListTripsDataSource = UITableViewDiffableDataSource<Section, TruckingTrip>


    // MARK: - IBActions
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Vars & Constants
    private let messageView: MessageView = .init()
    private let indicator = UIActivityIndicatorView(style: .large)

    private lazy var presenter: ListTripsPresenter! = {
        ListTripsPresenter(dependencies: ListTripsPresenter.Dependencies(view: self))
    }()
    private lazy var dataSource = makeDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }

    private func setupUI() {
        setupMessageView()
        setupActivityIndicatorView()
    }

    private func setupMessageView() {
        view.addSubview(messageView)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            messageView.heightAnchor.constraint(equalTo: tableView.heightAnchor),
            messageView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
        messageView.isHidden = true
    }

    private func setupActivityIndicatorView() {
        indicator.center = view.center
        view.addSubview(indicator)
    }

    private func setupTableView() {
        tableView.delegate = self
        registerCells()
        setupInitialSnapshot()
    }

    private func registerCells() {
        let nib = UINib(nibName: ListTripTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListTripTableViewCell.reuseIdentifier)
    }

    private func setupInitialSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([])
        dataSource.apply(snapshot, animatingDifferences: false)
        presenter.listTrips()
    }

    private func makeDataSource() -> ListTripsDataSource {
        let dataSource = ListTripsDataSource(tableView: tableView) { (tableView, indexPath, trip) -> UITableViewCell? in
            return self.createTripCell(tableView, indexPath: indexPath, trip: trip)
        }
        return dataSource
    }

    // MARK: - IBActions
    @IBAction private func sort(_ sender: Any) {
        let alert = UIAlertController(title: Constants.sortTripsTitle, message: Constants.sortTripsMessage, preferredStyle: .actionSheet)
        let sorts: [SortTrip] = SortTrip.allCases
        sorts.forEach({ sort in
            alert.addAction(
                UIAlertAction(title: sort.title, style: .default) { [weak self] _ in
                    self?.presenter.sortTripsBy(sort)
                }
            )
        })
        present(alert, animated: true)
    }

    @IBAction private func refreshData(_ sender: Any) {
        indicator.startAnimating()
        messageView.isHidden = true
        presenter.refreshTrips()
    }
}

// MARK: - UITableView Cells creation
private extension ListTripsViewController {
    func createTripCell(_ tableView: UITableView, indexPath: IndexPath, trip: TruckingTrip) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTripTableViewCell.reuseIdentifier) as? ListTripTableViewCell
        cell?.setup(
            idText: String(format: Constants.tripIDFormat, trip.id),
            distanceText: String(format: Constants.tripDistanceFormat, trip.truckingOrder.tripDistanceMiles)
        )
        return cell
    }
}

extension ListTripsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trip = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        let vc = MapTripViewController(trip: trip)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ListTripsView delegate
extension ListTripsViewController: ListTripsView {
    func errorGettingTrips(_ error: Error) {
        messageView.set(message: error.localizedDescription)
        messageView.isHidden = false
    }

    func endRefreshing() {
        indicator.stopAnimating()
    }

    func updateTrips(_ trips: [TruckingTrip]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.trips])
        snapshot.appendItems(trips, toSection: .trips)
        dataSource.apply(snapshot)
    }
}
