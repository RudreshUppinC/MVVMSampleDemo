//
//  ViewController.swift
//  SwiftMVVMApp
//
//  Created by DarkMoon on 16/04/25.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Properties
    private var viewModel: PhotoListViewModel!
    
    
    @IBOutlet weak var tableView: UITableView!
    private let photoService: PhotoFetching = APIService()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        viewModel = PhotoListViewModel(photoService: self.photoService)
        viewModel.fetchPhotos()
        setupBindings()
        
    }
    
    // MARK: - Setup
    private func setUpTableView() {
        let nibname = UINib(nibName: AppStrings.PhotoTableViewCell.rawValue, bundle: nil)
        tableView.register(nibname, forCellReuseIdentifier: AppStrings.PhotoTableViewCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - View Model Binding
    private func setupBindings() {
        // Observe the ViewModel's onUpdate callback
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                print("--- Data updated, reloading table view ---")
                self?.tableView.reloadData()
            }
        }
        
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getnumberOfPhotos()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let customCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.PhotoTableViewCell.rawValue, for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        
        let photo = viewModel.photo(at: indexPath.row)
        customCell.configure(at: photo!)
            
        return customCell
    }
}

