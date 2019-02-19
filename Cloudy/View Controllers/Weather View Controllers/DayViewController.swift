//
//  DayViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 01/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol DayViewControllerDelegate {
    func controllerDidTapSettingsButton(controller: DayViewController)
    func controllerDidTapLocationButton(controller: DayViewController)
}

class DayViewController: WeatherViewController {

    // MARK: - Properties

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    // MARK: Delegate

    var delegate: DayViewControllerDelegate?

    // MARK: Instatiate an instance of the DayView_VM

//    var now: WeatherData? {
//        didSet {
//            updateView()
//        }
//    }
    
    var viewModel: DayViewModel? {
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

    }

    private func updateView() {
        activityIndicatorView.stopAnimating()

        if let viewModel = viewModel {
            updateWeatherDataContainer(withViewModel: viewModel)

        } else {
            messageLabel.isHidden = false
            messageLabel.text = "Cloudy was unable to fetch weather data."

        }
    }

    // MARK: -

    // private func updateWeatherDataContainer(withWeatherData weatherData: WeatherData) {
    private func updateWeatherDataContainer(withViewModel viewModel: DayViewModel) {
        weatherDataContainer.isHidden = false
        
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        iconImageView.image = imageForIcon(withName: viewModel.iconImageName)
        windSpeedLabel.text = viewModel.windspeed
        descriptionLabel.text = viewModel.summary
        temperatureLabel.text = viewModel.temperature
        
    }

    // MARK: - Actions

    @IBAction func didTapSettingsButton(sender: UIButton) {
        delegate?.controllerDidTapSettingsButton(controller: self)
    }

    @IBAction func didTapLocationButton(sender: UIButton) {
        delegate?.controllerDidTapLocationButton(controller: self)
    }

}
