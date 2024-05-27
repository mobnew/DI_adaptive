//
//  SecondViewController.swift
//  DI_adaptive
//
//  Created by Aleksei Kurazhov on 27.05.2024.
//

import UIKit

class SecondViewController: UIViewController {
    
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "digitalIntercomBackground"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cameraImageView: UIImageView = {
       let view = UIImageView(image: UIImage(named: "CameraAndSpeakers"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tempView: UIView = {
      let view = UIView()
        
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewForButton: UIStackView = {
       let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var redView: UIView = {
        let view = UIView()
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: viewForButton.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: viewForButton.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func createButton() -> UIButton {
        let button = UIButton(type: .custom)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 72),
            button.widthAnchor.constraint(equalToConstant: 72)
        ])
        button.setTitle("1", for: .normal)
        button.layer.cornerRadius = 36
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .systemGray2
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
   
    private func setupViews() {
        view.backgroundColor = .systemGray
        
        view.addSubview(backgroundView)
        view.addSubview(cameraImageView)
        view.addSubview(tempView)
        view.addSubview(viewForButton)
        
        viewForButton.sub
        
        title = "Виртуальный домофон"
        
        navigationController?.navigationBar.tintColor = .black
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cameraImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cameraImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cameraImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cameraImageView.heightAnchor.constraint(equalTo: cameraImageView.widthAnchor, multiplier: 0.2617),
            
            tempView.leadingAnchor.constraint(equalTo: cameraImageView.leadingAnchor),
            tempView.trailingAnchor.constraint(equalTo: cameraImageView.trailingAnchor),
            tempView.topAnchor.constraint(equalTo: cameraImageView.bottomAnchor, constant: 16),
            tempView.heightAnchor.constraint(equalTo: cameraImageView.heightAnchor, multiplier: 0.8),
            
            viewForButton.leadingAnchor.constraint(equalTo: cameraImageView.leadingAnchor),
            viewForButton.trailingAnchor.constraint(equalTo: cameraImageView.trailingAnchor),
            viewForButton.topAnchor.constraint(equalTo: tempView.bottomAnchor, constant: 16),
            viewForButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16),
            
        ])
    }

}
