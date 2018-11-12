//
//  CarsListViewController.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CarsListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableStateLabel: UILabel!
    
    var viewModel: CarsListViewModel!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        
        bindViewModel()
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        tableView.register(R.nib.taxiItemCell)
    }
    
    private func configureNavigationBar() {
        title = R.string.localizeble.carsList_FindYourCar()
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    // MARK: - Private
    
    // MARK: - Bindings
    
    private func bindViewModel() {
        bindInputs()
        bindOutpus()
    }
    
    private func bindInputs() {
        tableView.rx.itemSelected
            .throttle(1, scheduler: MainScheduler.instance)
            .bind(to: viewModel.listViewItemSelected)
            .disposed(by: disposeBag)
    }
    
    private func bindOutpus() {
        bindState()
        bindViewItems()
    }
    
    private func bindState() {
        viewModel.state
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (state) in
                self?.tableStateLabel.isHidden = false
                
                switch state {
                case .empty:
                    self?.tableStateLabel.text = R.string.localizeble.common_NoData()
                case .loading:
                    self?.tableStateLabel.text = R.string.localizeble.common_Loading() + "..."
                case .loaded:
                    self?.tableStateLabel.isHidden = true
                    self?.tableStateLabel.text = nil
                case .failed(let errorMeeesage):
                    self?.tableStateLabel.text = errorMeeesage
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewItems() {
        let identifier = R.reuseIdentifier.taxiItemCell.identifier
        viewModel.viewItems
            .bind(to: tableView.rx.items(cellIdentifier: identifier, cellType: TaxiItemCell.self)) { (_, item, cell) in
                cell.configure(with: TaxiItemCell.Configuration(title: item.title, rotationAngle: item.rotationAngle))
            }
            .disposed(by: disposeBag)
    }
}
