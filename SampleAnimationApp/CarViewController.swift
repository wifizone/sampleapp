//
//  CarViewController.swift
//  SampleAnimationApp
//
//  Created by Антон Полуянов on 22/10/2019.
//  Copyright © 2019 Антон Полуянов. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {
    
    private var carImageView: UIImageView?
    private var currentBearingAngleInRadians: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addCarImageView()
        configureConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    private func addCarImageView() {
        let carImage = UIImage(named: "top-view-car-icon")
        carImageView = UIImageView(image: carImage)
        carImageView?.translatesAutoresizingMaskIntoConstraints = false
        guard let carImageView = carImageView else { return }
        view.addSubview(carImageView)
    }
    
    private func configureConstraints() {
        guard let carImageView = carImageView else { return }
        NSLayoutConstraint.activate([
            carImageView.widthAnchor.constraint(equalToConstant: 70),
            carImageView.heightAnchor.constraint(equalToConstant: 70),
            carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    // MARK: - Tap handling
    
    @objc func tapGestureHandler(gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: view)
        UIView.animate(withDuration: 1) {
            self.carImageView?.center = location
        }
    }
    
    private func carRotation(fromPoint: CGFloat toPoint: CGFloat) -> CGFloat {
        
    }
}

extension CarViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension UIView {
    // док
    func rotate(by angleInRadians: CGFloat) {
        let rotation = self.transform.rotated(by: angleInRadians)
        self.transform = rotation
    }
}
