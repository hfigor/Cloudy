//
//  WeekViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 01/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol WeekViewControllerDelegate: class {
    func controllerDidRefresh(controller: WeekViewController)
}

class WeekViewController: WeatherViewController {

    // MARK: - Properties

    @IBOutlet var tableView: UITableView!

    // MARK: -

    var delegate: WeekViewControllerDelegate?
    
    // MARK: -

   // var week: [WeatherDayData]? { when viewController interacted with model directly
    var viewModel: WeekViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Public Interface

    override func reloadData() {
        updateView()
    }
    
    // MARK: - View Methods

    private func setupView() {
        setupTableView()
        setupRefreshControl()
    }

    private func updateView() {
        activityIndicatorView.stopAnimating()
        tableView.refreshControl?.endRefreshing()

        if let _ = viewModel {
            updateWeatherDataContainer()

        } else {
            messageLabel.isHidden = false
            messageLabel.text = "Cloudy was unable to fetch weather data."
            
        }
    }

    // MARK: -

    private func setupTableView() {
        tableView.separatorInset = UIEdgeInsets.zero
    }

    private func setupRefreshControl() {
        // Initialize Refresh Control
        let refreshControl = UIRefreshControl()

        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(WeekViewController.didRefresh(sender:)), for: .valueChanged)

        // Update Table View)
        tableView.refreshControl = refreshControl
    }

    // MARK: -

   //  private func updateWeatherDataContainer(withWeatherData weatherData: [WeatherDayData]) {
    private func updateWeatherDataContainer() {
        weatherDataContainer.isHidden = false

        tableView.reloadData()
    }

    // MARK: - Actions

    @objc func didRefresh(sender: UIRefreshControl) {
        delegate?.controllerDidRefresh(controller: self)
    }
    
}

extension WeekViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0}
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfDays
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // By making it clear that we expect a WeatherDayTableViewCell instance, the dequeueReusableCell(for:) method can substitute its generic type for a concrete type.
        let cell:WeatherDayTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        if let viewModel = viewModel?.viewModel(for: indexPath.row) {
            // Weather Data Fetched in viewModel (WeekViewModel)
            
            // Configure Cell
            cell.configure(withViewModel: viewModel)
        }
        return cell
    }

}
