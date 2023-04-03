//
//  MainPresenter.swift
//  TestTask
//
//  Created by Александр Молчан on 3.04.23.
//

import UIKit

protocol MainPresenterDelegate: AnyObject {
    func presentGroups(group: FoodGroup)
    func presentCategoryes(_ categoryes: [String])
    func loadingFailure()
    func presentFoodModel(title: String, message: String)
    
    func startLoading()
    func stopLoading()
}

final class MainPresenter {
    
    weak var delegate: MainPresenterDelegate?
    private var categoryArray = ["Pasta", "Seafood", "Vegetarian", "Chicken"]

    public func setViewDelegate(delegate: MainPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getData() {
        self.delegate?.presentCategoryes(categoryArray)
        self.categoryArray.forEach { category in
            self.delegate?.startLoading()
            GenerycProvider<FoodGroup>().getData(api: .getFoodGroyp(category: category)) { [weak self] group in
                self?.delegate?.presentGroups(group: group)
                self?.delegate?.stopLoading()
            } failure: { error in
                print(error)
                self.delegate?.stopLoading()
                self.delegate?.loadingFailure()
            }
        }
    }
    
    public func selectFoodModel(model: FoodModel) {
        delegate?.presentFoodModel(title: model.name, message: model.imageUrl)
    }

}
