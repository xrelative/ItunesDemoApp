//
//  RootRouter.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/9/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import UIKit

class RootRouter: Router {
    static func showRootViewController() -> UIViewController {
        let searcher = SearcherWireframe()
        return UINavigationController(rootViewController: searcher.assemble())
    }
}
