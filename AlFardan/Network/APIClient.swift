//
//  APIClient.swift
//  AlFardan
//
//  Created by EDS on 17/10/2023.
//

import Foundation
import Combine
import Alamofire

class APIClient {
    
    func post<T: Codable>(urlString: String = "", model: T.Type, params: [String: Any]) async throws -> T {
        let response = try await combineAPICall(urlString: urlString, model: T.self, method: .post, params: params)
        if let value = response.value {
            return value
        } else {
            throw response.error!
        }
    }
    
    private func combineAPICall<V: Decodable>(urlString: String = "", model: V.Type,
                                              method: HTTPMethod,
                                              params: [String: Any]?) async throws -> DataResponse<V, AFError> {
        let dataTask = AF.request(urlString, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).serializingDecodable(V.self)
        let response = await dataTask.response
        return response
    }
}
