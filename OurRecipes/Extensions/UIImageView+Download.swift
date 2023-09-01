//
//  UIImageView+Download.swift
//  BonAppetit
//
//  Created by Vanessa Hurla on 21/02/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from url: String, completion: (() -> Void)? = nil) {
        guard let imageURL = URL(string: url) else {
            return
        }
        getData(from: imageURL) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
                completion?()
            }
        }
    }
}

private extension UIImageView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
