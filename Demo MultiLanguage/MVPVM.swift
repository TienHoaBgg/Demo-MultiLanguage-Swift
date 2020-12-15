//
//  BaseViewModel.swift
//  KickEnglish
//
//  Created by gem on 8/18/20.
//  Copyright © 2020 gem. All rights reserved.
//

import Foundation
import UIKit

public enum ViewType {
    case storyboardViewController(storyboardName: String, viewControllerID: String)
    case legacyViewController(viewControllerID: String)
    case standaloneViewController(_ viewController: UIViewController)
}

public protocol ViewModelParamProtocol {}

public protocol ViewProtocol: class {
    associatedtype ViewModel: ViewModelProtocol
    
    var viewModel: ViewModel! { get set }
    static var viewType: ViewType { get }

    static func create<V>() -> V where V: ViewProtocol
    static func createWithParams<V>(_ params: V.ViewModel.ViewModelParams?) -> V where V: ViewProtocol
    
    func onViewEvent(_ event: ViewModel.ViewEvent)
}

public extension ViewProtocol {
    func onViewEvent(_ event: ViewModel.ViewEvent) {}
    
    static func create<V>() -> V where V: ViewProtocol {
        return createWithParams(nil)
    }
    
    static func createWithParams<V>(_ params: V.ViewModel.ViewModelParams?) -> V where V: ViewProtocol {
        var view: V
        switch viewType {
        case .storyboardViewController(let storyboardName, let controllerID):
            view = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: controllerID) as! V
        case .legacyViewController(let controllerID):
            view = UIViewController(nibName: controllerID, bundle: nil) as! V
        case .standaloneViewController(let v):
            view = v as! V
        }
        
        view.viewModel = V.ViewModel.init(params: params)
        view.viewModel.onViewEvent = { [weak view] (event) in
            view?.onViewEvent(event)
        }
        return view
    }
}

public protocol ViewModelAction {}
public protocol ViewEventProtocol {}

public protocol ViewModelProtocol {
    associatedtype ViewEvent: ViewEventProtocol
    associatedtype Action: ViewModelAction
    associatedtype ViewModelParams: ViewModelParamProtocol
    
    var onViewEvent: ((ViewEvent) -> Void)? { get set }
    
    func dispatch(action: Action)
    func performAction(_ action: Action) -> [ViewEvent]
    func dispose()
    
    init(params: ViewModelParams?)
}

public extension ViewModelProtocol {
    func dispose() {}
    
    func dispatch(action: Action) {
        DispatchQueue.main.async {
            let events = self.performAction(action)
            for event in events {
                self.onViewEvent?(event)
            }
        }
    }
    
    func dispatch(actions: [Action]) {
        for action in actions {
            dispatch(action: action)
        }
    }
}
