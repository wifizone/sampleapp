//
//  CarViewPresenter.swift
//  SampleAnimationApp
//
//  Created by Anton Poluianov on 24/10/2019.
//  Copyright © 2019 Антон Полуянов. All rights reserved.
//

import Foundation

/// Протокол принимает события от вьюшки/вьюконтроллера
protocol CarViewPresenterInputProtocol {
	
	/// Пользователь выбрал новую точку для машины на экране
	func didTapNewCarLocation()
	
	/// Анимация передвижения машины закончилась
	func didFinishAnimatingCar()
}

/// Протокол дает задачи вьюшке/вьюконтроллеру
protocol CarViewProtocol {
	
	/// Переместить машину в новую точку анимированно
	func routeCarAnimated()
}

/// Презентер экрана с машиной
class CarViewPresenter {
    
	private var carView: CarViewProtocol
	private var isAnimating: Bool = false
	
	/// Конструктор презентера
	///
	/// - Parameter carView: вью/вьюконтроллер с машиной
	init(carView: CarViewProtocol) {
		self.carView = carView
	}
}

extension CarViewPresenter: CarViewPresenterInputProtocol {
    
	func didTapNewCarLocation() {
		if (!isAnimating) {
			self.carView.routeCarAnimated()
			isAnimating = true
		}
	}
	
	func didFinishAnimatingCar() {
		isAnimating = false
	}
}
