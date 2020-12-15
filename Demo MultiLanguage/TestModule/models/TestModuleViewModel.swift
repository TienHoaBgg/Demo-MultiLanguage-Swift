//
//  TestModuleViewModel.swift
//  Demo MultiLanguage
//
//  Created by GEM on 12/15/20.
//

import Foundation
import UIKit

struct TestModuleViewModelParams: ViewModelParamProtocol {
    let rowCount: Int
}

enum TestModuleViewModelAction: ViewModelAction {
    case loadData(rowCount: Int)
    case `nil`
}

enum TestModuleViewEvent: ViewEventProtocol {
    case showData(String)
    case `nil`
}

class TestModuleViewModel: ViewModelProtocol {
    var onViewEvent: ((TestModuleViewEvent) -> Void)?
    var rowCount: Int = 0
    
    required init(params: TestModuleViewModelParams?) {
        rowCount = params?.rowCount ?? 0
    }
    
    func performAction(_ action: TestModuleViewModelAction) -> [TestModuleViewEvent] {
        switch action {
        case .loadData( _):
            return [ .showData("a") ]
        default: break
        }
        return [ .nil ]
    }
}
