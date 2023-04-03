//
//  NetworkManager.swift
//  TestTask
//
//  Created by Александр Молчан on 3.04.23.
//

import Foundation
import Moya

typealias ObjectBlock<T: Decodable> = ((T) -> Void)
typealias Failure = ((Error) -> Void)

final class GenerycProvider<T: Decodable> {
    let provider = MoyaProvider<FoodAPI>(plugins: [NetworkLoggerPlugin()])

    func getData(api: FoodAPI, success: ObjectBlock<T>?, failure: Failure?) {
        provider.request(api) { result in
            switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(T.self, from: response.data)
                        success?(data)
                    } catch let error {
                        failure?(error)
                    }
                case .failure(let error):
                    failure?(error)
            }
        }
    }
    
}
