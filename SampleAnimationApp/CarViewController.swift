//
//  CarViewController.swift
//  SampleAnimationApp
//
//  Created by Антон Полуянов on 22/10/2019.
//  Copyright © 2019 Антон Полуянов. All rights reserved.
//

import UIKit

/// Вью контроллер для отображения двигающейся машины
class CarViewController: UIViewController {
	
    /// Презентер вьюшки
	var presenter: CarViewPresenterInputProtocol?
	
	private var carImageView: UIImageView?
	private var tapGesture: UITapGestureRecognizer {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
		return tapGesture
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		addCarImageView()
		configureConstraints()
	}
	
	private func configureView() {
		view.backgroundColor = .white
		tapGesture.delegate = self
		view.addGestureRecognizer(tapGesture)
	}
	
	private func addCarImageView() {
		let carImage = UIImage(named: "car")
		let carImageView = UIImageView(image: carImage)
		carImageView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(carImageView)
		self.carImageView = carImageView
	}
	
	private func configureConstraints() {
		guard let carImageView = carImageView else { return }
		NSLayoutConstraint.activate([
			carImageView.widthAnchor.constraint(equalToConstant: 60),
			carImageView.heightAnchor.constraint(equalToConstant: 100),
			carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			carImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
			])
	}
}

extension CarViewController: CarViewProtocol {
    func routeCarAnimatedTo(point: Point) {
        let destinationPoint = CGPoint(x: point.x, y: point.y)
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5/3.0, animations: {
                self.rotateCar(to: destinationPoint)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5/3.0, relativeDuration: 2.5/3.0, animations: {
                guard let carImageView = self.carImageView else { return }
                carImageView.center = destinationPoint
            })
        }, completion: { (_) in
            self.presenter?.didFinishAnimatingCar()
        })
    }
	
	private func rotateCar(to destinationPoint:CGPoint) {
		guard let carImageView = carImageView else { return }
		let rotationAngle = atan2(destinationPoint.y - carImageView.center.y, destinationPoint.x - carImageView.center.x) + CGFloat.pi/2
		let currentAngle = atan2(carImageView.transform.b, carImageView.transform.a);
		let resultingAngle = rotationAngle - currentAngle
		carImageView.rotate(by: resultingAngle)
	}
}

extension CarViewController: UIGestureRecognizerDelegate {
	
	@objc func tapGestureHandler(gestureRecognizer: UITapGestureRecognizer) {
		let destinationPoint = gestureRecognizer.location(in: view)
        self.presenter?.didTapNewCarLocationAt(point: Point(x: Double(destinationPoint.x), y: Double(destinationPoint.y)))
	}
	
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}

extension UIView {
    
	/// Метод для поворота вьюшки
	///
	/// - Parameter angle: угол в радианах
	func rotate(by angle: CGFloat) {
		let rotation = self.transform.rotated(by: angle)
		self.transform = rotation
	}
}
