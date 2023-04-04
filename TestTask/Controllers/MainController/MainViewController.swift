//
//  MainViewController.swift
//  TestTask
//
//  Created by Александр Молчан on 3.04.23.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController, MainPresenterDelegate {
    private lazy var titleButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        button.setTitle("Select City", for: .normal)
        button.setImage(UIImage(systemName: "chevron.down", withConfiguration: configuration), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = .black
        return button
    }()
    
    private lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
 //       tableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tableView.rowHeight = UITableView.noIntrinsicMetric
        return tableView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let presenter = MainPresenter()
    private var categoryArray = [String]()
    
    private var foodArray = [TotalFoodModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var selectedCategory = IndexPath(row: 0, section: 0) {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerConfiguration()
        addTableObserver()
        presenter.getData()
    }
    
    private func controllerConfiguration() {
        registerCells()
        layoutElements()
        makeConstraints()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        presenter.delegate = self
    }
    
    // MARK: -
    // MARK: - Add Observers

    private func addTableObserver() {
        tableView.addObserver(self, forKeyPath: "contentSize", options: [.new, .old, .prior], context: nil)
    }
    
    @objc override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
             remakeTableViewHeight()
        }
    }
    
    // MARK: -
    // MARK: - Presenter Methods
    
    func presentGroups(model: TotalFoodModel) {
        self.foodArray.append(model)
        foodArray.sort(by: { $0.category < $1.category })
    }
    
    func presentCategoryes(_ categoryes: [String]) {
        self.categoryArray = categoryes
        self.categoryCollectionView.reloadData()
    }
    
    func startLoading() {
        spinner.startAnimating()
    }
    
    func stopLoading() {
        spinner.stopAnimating()
    }
    
    func presentFoodModel(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func loadingFailure() {
        let alert = UIAlertController(title: "Network Error", message: "Please, try again later.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // MARK: -
    // MARK: - UI Settings
    
    private func registerCells() {
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.id)
        bannerCollectionView.register(BannerCollectionCell.self, forCellWithReuseIdentifier: BannerCollectionCell.id)
        categoryCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.id)
    }
    
    private func layoutElements() {
        view.addSubview(titleButton)
        view.addSubview(tableView)
        view.addSubview(spinner)
        view.bringSubviewToFront(spinner)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 112))
        headerView.addSubview(bannerCollectionView)
        tableView.tableHeaderView = headerView
    }
    
    private func makeConstraints() {
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).inset(-16)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(20)
        }
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        bannerCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func remakeTableViewHeight() {
        let contentSize = self.tableView.contentSize.height
        self.tableView.snp.updateConstraints { make in
            make.height.equalTo(contentSize)
        }
    }
    
}

// MARK: -
// MARK: - CollectionView Extencion

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return 3
        } else {
            return categoryArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionCell.id, for: indexPath)
        if collectionView == bannerCollectionView {
            guard let topCell = cell as? BannerCollectionCell else { return cell }
            return topCell
        } else {
            cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.id, for: indexPath)
            guard let categoryCell = cell as? CollectionCell else { return cell }
            categoryCell.isSelected = indexPath == selectedCategory
            categoryCell.set(category: categoryArray[indexPath.row])
            return categoryCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        if collectionView == bannerCollectionView {
            return CGSize(width: 300, height: 112)
        } else {
            let width = ((screenWidth - 60) / 3)
            let height = 32.0
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            selectedCategory = indexPath
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            if let index = foodArray.firstIndex(where: { $0.category == categoryArray[indexPath.row] }) {
                tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: true)
            }
        }
    }
    
}

// MARK: -
// MARK: - TableView Extension

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TableCell(model: foodArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectFoodModel(model: foodArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 0))
        header.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        header.addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
            make.height.equalTo(32)
        }
        return header
    }
    
    // MARK: -
    // MARK: - Some bugs here(
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard let category = (tableView.visibleCells.first as? TableCell)?.model.category else { return }
//        if let index = categoryArray.firstIndex(where: { $0 == category }) {
//            selectedCategory = IndexPath(row: index, section: 0)
//        }
//    }

}

