//
//  ApiService.swift
//  Iris
//
//  Created by Balamurugan on 03/09/25.
//
import Foundation

final class ApiService {
    
    //Api request call
    static func request<T: Decodable>(
        from urlString: String,
        as type: T.Type
    ) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw ErrorCase.invalidURL
        }

        print("Requesting API: \(url.absoluteString)")

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ErrorCase.invalidResponse
        }

        print("Response Status: \(httpResponse.statusCode)")

        guard httpResponse.statusCode == 200 else {
            let bodyString = String(data: data, encoding: .utf8) ?? "No Body"
            print("API Error Body: \(bodyString)")
            throw ErrorCase.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            let bodyString = String(data: data, encoding: .utf8) ?? "No Body"
            print("Decoding failed. Raw response:\n\(bodyString)")
            throw ErrorCase.invalidData
        }
    }
}
