//
//  AddLocationViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 10/07/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

protocol AddLocationViewControllerDelegate {
    func controller(_ controller: AddLocationViewController, didAddLocation location: Location)
}

class AddLocationViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var activityIndicatorView:UIActivityIndicatorView!
    // MARK: -

    var viewModel: AddLocationViewViewModel!
    
    private let disposeBag = DisposeBag()
    
   // private var locations: [Location] = []

    // MARK: -

    //private lazy var geocoder = CLGeocoder()

    // MARK: -

    var delegate: AddLocationViewControllerDelegate?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Location"
        
        // Initialize the View Model -- this will move to the LocationsViewController to be injected
        viewModel = AddLocationViewViewModel(query: searchBar.rx.text.orEmpty.asDriver(), locationService: Geocoder())
        
        // Drive the Table View:
        // Because the view model is owned by the view controller, we use an unowned reference to self within the closure.
        
        viewModel.locations.drive(onNext: { [unowned self](_) in
            // update Table View
            self.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        
        // Drive the Activity Indicator View
        viewModel.querying.drive(activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Show Keyboard
        searchBar.becomeFirstResponder()
        
        // Searchbar Clicked
        searchBar.rx.searchButtonClicked
            .asDriver(onErrorJustReturn: ())//.asDriver(onErrorJustReturn: ())
            .drive(onNext: { [unowned self] in
                self.searchBar.resignFirstResponder()
            })
        .disposed(by: disposeBag)
        
        // Cancel Button Clicked
        searchBar.rx.cancelButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [unowned self] in
                self.searchBar.resignFirstResponder()
            })
        .disposed(by: disposeBag)
    }

    // MARK: - View Methods

    private func setupView() {

    }

    private func updateView() {

    }
}

extension AddLocationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLocations
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell else { fatalError("Unexpected Table View Cell") }
        
        if let viewModel = viewModel.viewModelForLocation(at: indexPath.row) {
            
            // Configure Table View Cell
            cell.configure(withViewModel: viewModel)
        }
        return cell
    }
}

extension AddLocationViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Fetch Location
        guard let location = viewModel.location(at: indexPath.row) else { return }

        // Notify Delegate
        delegate?.controller(self, didAddLocation: location)

        // Pop View Controller From Navigation Stack
        navigationController?.popViewController(animated: true)
    }

}

extension AddLocationViewController: UISearchBarDelegate {
    
}
