//
//  LocalDataClient.swift
//  FATIMA
//
//  Created by EDS on 21/10/2022.
//

import Foundation
import SwiftyJSON
import Combine

struct LocalDataClient {
    private func load(fileName: String, type: String = "json") async throws -> Data {
        guard let path = Bundle.main.path(forResource: fileName, ofType: type) else {
            throw NSError(domain: "com.waqas.ali", code: 1, userInfo: ["message" : "path now found"])
        }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        } catch let error {
            throw error
        }
    }
    
    func fetchUser() async throws -> UserModel {
        return try await self.generic(model: UserModel.self, fileName: "Login")
    }
}

extension LocalDataClient {
    func generic<T: Codable>(model: T.Type,
                             fileName: String) async throws -> T {
        do {
            let data = try await self.load(fileName: fileName)
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                return response
            } catch let error {
                throw error
            }
        } catch let error {
            throw error
        }
    }
}
