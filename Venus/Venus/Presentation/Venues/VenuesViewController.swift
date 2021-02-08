//
//  VenuesViewController.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import UIKit
import CoreLocation

class VenuesViewController: UIViewController {
    
    private lazy var contentView: VenuesView = {
        return VenuesView()
    }()
    
    private lazy var radiusBarButton: UIBarButtonItem = {
        UIBarButtonItem(image: #imageLiteral(resourceName: "ic_radius"), style: .plain, target: self, action: #selector(didTapRadiusButton))
    }()

    
    private let locationManager = CLLocationManager()
    
    private var viewModel: VenuesViewModel = VenuesViewModel()
    
    override func loadView() {
        view = contentView
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        title = "Venus"
        navigationItem.rightBarButtonItem = radiusBarButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.venuesTableView.register(VenuesTableViewCell.self, forCellReuseIdentifier: VenuesTableViewCell.reuseIdentifier)
    
        contentView.venuesTableView.delegate = self
        contentView.venuesTableView.dataSource = self
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        }
        
        viewModel.onDataChanged = { [weak self] in
            self?.handleDataReceived()
        }
    }
    
    private func handleDataReceived() {
        contentView.loadingVenuesLabel.isHidden = true
        contentView.venuesTableView.isHidden = viewModel.venuesCount() == 0
        contentView.noVenuesFoundLabel.isHidden = viewModel.venuesCount() != 0
        contentView.venuesTableView.reloadData()
    }
    
    private func showAlertController(title: String? = nil, message: String? = nil,
                                     positiveButton: String? = nil, negativeButton: String? = nil,
                                     positiveHandler: (() -> Void)? = nil, negativeHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let positiveButton = positiveButton {
            alertController.addAction(UIAlertAction(title: positiveButton, style: .default, handler: { _ in
                positiveHandler?()
            }))
        }

        if let negativeButton = negativeButton {
            alertController.addAction(UIAlertAction(title: negativeButton, style: .cancel, handler: { _ in
                negativeHandler?()
            }))
        }

        present(alertController, animated: true, completion: nil)
    }
    
    @objc
    private func didTapRadiusButton() {
        let controller = RadiusViewController(currentRadius: viewModel.radius())
        controller.modalPresentationStyle = .overCurrentContext
        controller.delegate = self
        present(controller, animated: true)
    }
}

//MARK: - CLLocationManagerDelegate
extension VenuesViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            showAlertController(title: "Venus",
                                message: NSLocalizedString("Location Access is required for displaying venues near you.", comment: ""),
                                positiveButton: NSLocalizedString("OK", comment: ""))
            return
        }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }
        viewModel.latitude = userLocation.coordinate.latitude
        viewModel.longitude = userLocation.coordinate.longitude
        viewModel.loadVenues()
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //show a message when called repeatedly
    }
}

//MARK: - UITableViewDataSource
extension VenuesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.venuesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentView.venuesTableView.dequeueReusableCell(withIdentifier: VenuesTableViewCell.reuseIdentifier) as! VenuesTableViewCell
        cell.configure(model: viewModel.venue(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
}

//MARK: - UITableViewDelegate
extension VenuesViewController: UITableViewDelegate {}

//MARK: - RadiusViewControllerDelegate
extension VenuesViewController: RadiusViewControllerDelegate {
    
    func radiusViewControllerDidSelect(_ controller: RadiusViewController, newRadius: Int?) {
        if let radius = newRadius, radius != viewModel.radius() && viewModel.latitude != 0 || viewModel.longitude != 0 {
            viewModel.loadVenues(radius: newRadius)
        }
        radiusViewControllerDidCancel(controller)
    }
    
    func radiusViewControllerDidCancel(_ controller: RadiusViewController) {
        controller.dismiss(animated: true)
    }
}
