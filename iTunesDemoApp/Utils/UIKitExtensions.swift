//
//  UIKitExtensions.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/9/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import UIKit

protocol ReusableIdentifierProtocol {
    static var reusableIdentifier: String { get }
}

protocol NibProtocol {
    static var nib: UINib { get }
}

extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UITableViewCell: ReusableIdentifierProtocol {
    static var reusableIdentifier: String {
        return nameOfClass
    }
}

extension UIView: NibProtocol {
    static var nib: UINib {
        return UINib(nibName: nameOfClass, bundle: Bundle.main)
    }
}

extension UIViewController: NibProtocol {
    static var nib: UINib {
        return UINib(nibName: nameOfClass, bundle: Bundle.main)
    }
}

extension UIImageView {
    func loadFromUrl(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }

    func loadFromUrlString(from urlString: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: urlString) else { return }
        loadFromUrl(from: url, contentMode: mode)
    }
}
