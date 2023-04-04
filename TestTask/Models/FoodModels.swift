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

final class FoodModel: Decodable {
    var name: String
    var imageUrl: String
    var category: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case imageUrl = "strMealThumb"
    }
}
