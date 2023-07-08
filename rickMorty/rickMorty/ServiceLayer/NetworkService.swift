//
//  NetworkService.swift
//  rickMorty
//
//  Created by Александр Троицкий on 08.07.2023.
//

import Foundation
import UIKit

/// Протокол сетевого слоя
protocol NetworkServiceProtocol {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}

/// Cервис сетевого слоя
final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Public Methods
    
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(Characters.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedData.results))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                guard let error = error else { return }
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
