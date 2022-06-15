//
//  ApiManager.swift
//  iOS Native App Development Test
//
//  Created by Pieter Yonathan on 12/06/22.
//

import Foundation
import UIKit

class ApiManager {
    
    func parsingJson(completion: @escaping ([DataUser]) ->()){
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: ApiConstant.urlUser) { data, response, error in
            //Checking errors
            if error == nil, data != nil{
                let decoder = JSONDecoder()
                do{
                    let parsingData = try decoder.decode(DataApi.self, from: data!)
                    completion(parsingData.data)
                } catch{
                    print("Parsing Error")
                }
            }
        }
        dataTask.resume()
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


