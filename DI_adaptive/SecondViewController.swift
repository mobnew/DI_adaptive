//
//  SecondViewController.swift
//  DI_adaptive
//
//  Created by Aleksei Kurazhov on 27.05.2024.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    
    ///вью для подложки, чтобы небыло стыков
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "digitalIntercomBackground"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    ///картинка для камеры
    private lazy var cameraImageView: UIImageView = {
       let view = UIImageView(image: UIImage(named: "CameraAndSpeakers"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    ///тут было лень рисовать вью для статусов и номеров квартир
    private lazy var tempView: UIView = {
      let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    ///  StackView для блока кнопок содержит в себе еще 4 stackView, в которых распологаются кнопки
    private lazy var viewForButton: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            createSmallStackView(line: 1),
            createSmallStackView(line: 2),
            createSmallStackView(line: 3),
            createSmallStackView(line: 4)
        ])
        view.backgroundColor = .clear
        view.axis = .vertical
        view.spacing = 1
        view.distribution = .fillEqually
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for i in 0...10 {
            if let button = viewForButton.viewWithTag(i) as? UIButton {
                print("gggg \(i) \(button.frame.size.width) \(button.bounds.size.width)")
                if button.frame.size.width > 40 {
                    button.applyGradient(colours: [.white, .gray], cornerRadius: button.frame.width / 2)
                }
            }
        }
    }
    
    
    /// Горизонтальный StackView в котором распологаются по 3 кнопки
    private func createSmallStackView(line: Int) -> UIStackView {
        let smallStackView: UIStackView!
        switch line {
        case 1:
            smallStackView = UIStackView(arrangedSubviews: [
            createButton(digit: 1),
            createButton(digit: 2),
            createButton(digit: 3),
            ])
        case 2:
            smallStackView = UIStackView(arrangedSubviews: [
            createButton(digit: 4),
            createButton(digit: 5),
            createButton(digit: 6),
            ])
        case 3:
            smallStackView = UIStackView(arrangedSubviews: [
            createButton(digit: 7),
            createButton(digit: 8),
            createButton(digit: 9),
            ])
        case 4:
            smallStackView = UIStackView(arrangedSubviews: [
            createButton(digit: -1),
            createButton(digit: 0),
            createButton(digit: -2),
            ])
        default:
            smallStackView = UIStackView()
        }
        smallStackView.axis = .horizontal
        smallStackView.distribution = .equalSpacing
        smallStackView.alignment = .center
        smallStackView.backgroundColor = .clear
        smallStackView.translatesAutoresizingMaskIntoConstraints = false
        return smallStackView
    }
    
    /// Функция для создания кнопок
    private func createButton(digit: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitleColor(.black, for: .normal)
        button.sizeToFit()
        button.tag = digit
        if digit == 0 { button.tag = 10 }
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: view.frame.size.width / 4.5),
            button.widthAnchor.constraint(equalToConstant: view.frame.size.width / 4.5)
        ])
        button.layer.cornerRadius = view.frame.size.width / 9
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        switch digit {
        case 0...9:
            button.backgroundColor = .systemGray
            button.setTitle(String(digit), for: .normal)
            button.addTarget(self, action: #selector(tapNumButton(_:)), for: .touchUpInside)
        case -2:
            button.backgroundColor = .green
            button.setTitle("В", for: .normal)
            button.addTarget(self, action: #selector(tapCallButton), for: .touchUpInside)
        case -1:
            button.backgroundColor = .red
            button.setTitle("C", for: .normal)
            button.addTarget(self, action: #selector(tapClearButton), for: .touchUpInside)
        default:
            view.backgroundColor = .systemGray
            button.setTitle("?", for: .normal)
        }
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    @objc private func tapNumButton(_ sender: UIButton) {
        playPik()
        vibrate()
        
        ///добавляем анимацию нажатия
        let newColors = [UIColor.gray, UIColor.black]
        sender.updateGradientColors(colours: newColors, duration: 0.3)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let backColors = [UIColor.white, UIColor.gray]
            sender.updateGradientColors(colours: backColors, duration: 1.0)
        }
        
        
        print("tap \(sender.tag) button")
    }

    @objc private func tapCallButton() {
        print(#function)
    }

    @objc private func tapClearButton() {
        print(#function)
    }
    
    /// добавляем немного звука
    private func playPik() {
        guard let url = Bundle.main.url(forResource: "pik", withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    ///добавляем вибраций
    private func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    
    /// Настройка и привязка views
    private func setupViews() {
        view.backgroundColor = .systemGray
        
        view.addSubview(backgroundView)
        view.addSubview(cameraImageView)
        view.addSubview(tempView)
        view.addSubview(viewForButton)
        
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
            
            viewForButton.leadingAnchor.constraint(equalTo: cameraImageView.leadingAnchor,constant: 16),
            viewForButton.trailingAnchor.constraint(equalTo: cameraImageView.trailingAnchor,constant: -16),
            viewForButton.topAnchor.constraint(equalTo: tempView.bottomAnchor, constant: 25),
            viewForButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16),
        ])
    }

}


extension UIView {
    
    func applyGradient(colours: [UIColor], cornerRadius: CGFloat?)  {
        print(#function)
        let gradient: CAGradientLayer = CAGradientLayer()
        if let cornerRadius = cornerRadius {
            gradient.cornerRadius = cornerRadius
        }
        gradient.type = .radial
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0, y: 1.0)
        gradient.colors = colours.map { $0.cgColor }
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func updateGradientColors(colours: [UIColor], duration: TimeInterval) {
            guard let gradientLayer = self.layer.sublayers?.compactMap({ $0 as? CAGradientLayer }).first else { return }
            let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
            colorChangeAnimation.duration = duration
            colorChangeAnimation.toValue = colours.map { $0.cgColor }
            colorChangeAnimation.isRemovedOnCompletion = false
            colorChangeAnimation.fillMode = .forwards
            gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
        }
}
