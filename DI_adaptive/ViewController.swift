//
//  ViewController.swift
//  DI_adaptive
//
//  Created by Aleksei Kurazhov on 27.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(goToNext), for: .touchUpInside)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    @objc private func goToNext() {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 200),
            nextButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

}

