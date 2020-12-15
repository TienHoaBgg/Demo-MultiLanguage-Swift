//
//  TestModuleViewController.swift
//  Demo MultiLanguage
//
//  Created by GEM on 12/15/20.
//

import Foundation
import UIKit

class TestModuleViewController: UIViewController, ViewProtocol {
    static var viewType: ViewType = .storyboardViewController(storyboardName: "TestModule", viewControllerID: "TestModuleViewController")
    var viewModel: TestModuleViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.dispatch(action: .loadData(rowCount: 10))
    }
    
    func onViewEvent(_ event: TestModuleViewEvent) {
        switch event {
        
//        case .showData(let s):
            
        default: break
        }
    }
}
