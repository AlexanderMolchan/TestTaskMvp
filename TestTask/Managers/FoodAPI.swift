//
//  FoodAPI.swift
//  TestTask
//
//  Created by Александр Молчан on 3.04.23.
//

import Foundation
import Moya

enum FoodAPI {
    case getFoodGroyp(category: String)
}

extension FoodAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        var parameters = [String: Any]()
        switch self {
            case .getFoodGroyp(let category):
                parameters["c"] = category
        }
        return parameters
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .getFoodGroyp:
                return URLEncoding.queryString
        }
    }
    
}
