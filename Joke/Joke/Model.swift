//
//  Model.swift
//  Joke
//
//  Created by Эля Корельская on 17.11.2023.
//
import UIKit

final class Model {
    /// Документация по API: https://api.chucknorris.io
    func searchJokes(query: String, completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/search?query=\(query)") else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data,
                  let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let jokesArray = dictionary["result"] as? [[String: Any]]
            else {
                completion([])
                return
            }

            let jokes = jokesArray.compactMap { $0["value"] as? String }
            completion(jokes)
        }
        task.resume()
    }
}
