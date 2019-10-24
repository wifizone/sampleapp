//
//  CarApplicationRouter.swift
//  SampleAnimationApp
//
//  Created by Anton Poluianov on 24/10/2019.
//  Copyright © 2019 Антон Полуянов. All rights reserved.
//

import UIKit

/// Протокол роутера
protocol CarApplicationRouterProtocol {
	
	/// Отображение вьюконтроллера с машиной
	func presentMainCarViewController()
}

/// Роутер. Собирает презентеры и контроллеры, отображает
class CarApplicationRouter {
    
	private let window: UIWindow
	
	/// Конструктор роутера
	///
	/// - Parameter window: основной window в приложении
	init(window: UIWindow) {
		self.window = window
	}
}

extension CarApplicationRouter: CarApplicationRouterProtocol {
    
	func presentMainCarViewController() {
		let carViewController = CarViewController()
		let presenter = CarViewPresenter(carView: carViewController)
		carViewController.presenter = presenter
		window.rootViewController = carViewController
		window.makeKeyAndVisible()
	}
}
