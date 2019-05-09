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
