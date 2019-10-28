//
//  CarViewPresenter.swift
//  SampleAnimationApp
//
//  Created by Anton Poluianov on 24/10/2019.
//  Copyright © 2019 Антон Полуянов. All rights reserved.
//

import Foundation

/// Протокол принимает события от вьюшки/вьюконтроллера
protocol CarViewPresenterInputProtocol: AnyObject {
	
	/// Пользователь выбрал новую точку для машины на экране
    ///
    /// - Parameter point: точка, по которой тапнул пользователь
    func didTapNewCarLocationAt(point: Point)
	
	/// Анимация передвижения машины закончилась
	func didFinishAnimatingCar()
}

/// Протокол дает задачи вьюшке/вьюконтроллеру
protocol CarViewProtocol: AnyObject {
	
	/// Переместить машину в новую точку анимированно
    ///
    /// - Parameter point: точка, по которой тапнул пользователь
    func routeCarAnimatedTo(point: Point)
}

/// Презентер экрана с машиной
class CarViewPresenter {
    
	private weak var carView: CarViewProtocol?
	private var isAnimating: Bool = false
	
	/// Конструктор презентера
	///
	/// - Parameter carView: вью/вьюконтроллер с машиной
	init(carView: CarViewProtocol) {
		self.carView = carView
	}
}

extension CarViewPresenter: CarViewPresenterInputProtocol {
    func didTapNewCarLocationAt(point: Point) {
        if (!isAnimating) {
            self.carView?.routeCarAnimatedTo(point: point)
            isAnimating = true
        }
    }
	
	func didFinishAnimatingCar() {
		isAnimating = false
	}
}
