//
//  FoodModels.swift
//  TestTask
//
//  Created by Александр Молчан on 3.04.23.
//

import Foundation

struct FoodGroup: Decodable {
    var meals: [FoodModel]
}

struct FoodModel: Decodable {
    var name: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case imageUrl = "strMealThumb"
    }
}

final class TotalFoodModel {
    var name: String
    var imageUrl: String
    var category: String
    
    init(name: String, imageUrl: String, category: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.category = category
    }
}
