//
//  ViewController.swift
//  Multithreading Brute force HW
//
//  Created by Serhii  on 12/10/2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var isBlack: Bool = false {
        didSet {
            if isBlack {
                view.backgroundColor = .black
                textLable.textColor = .red
                activityIndicator.color = .red
                hackerImage.tintColor = .white

            } else {
                view.backgroundColor = .systemGray2
                textLable.textColor = .black
                activityIndicator.color = .black
                hackerImage.tintColor = .black
            }
        }
    }

    var isStarted: Bool = false {
        didSet {
            if isStarted {
                startButton.backgroundColor = .systemRed
                startButton.setTitle("Stop", for: .normal)
                randomStack.isHidden = true
            } else {
                startButton.backgroundColor = .systemGreen
                startButton.setTitle("Start", for: .normal)
                randomStack.isHidden = false
            }
        }
    }

    // MARK: - Outlets

    private lazy var hackerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hacker")
        return imageView
    }()

    private lazy var textLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .red
        lable.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return lable
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введие пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        return textField
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return activityIndicator
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemGreen
        button.tintColor = .black
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var passwordLengthLable: UILabel = {
        let lable = UILabel()
        lable.text = "3"
        lable.textColor = .white
        lable.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return lable
    }()

    private lazy var passwordLengthSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 3
        slider.maximumValue = 10
        slider.minimumTrackTintColor = .systemYellow
        slider.maximumTrackTintColor = .white
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        return slider
    }()

    private lazy var randomPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Random", for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemYellow
        button.tintColor = .black
        button.addTarget(self, action: #selector(randomPasswordButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var changeViewColorButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Color", for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemYellow
        button.tintColor = .black
        button.addTarget(self, action: #selector(changeViewColorButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var randomStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupLayout()

        self.isBlack.toggle()

    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.addSubview(hackerImage)
        view.addSubview(textLable)
        view.addSubview(passwordTextField)
        view.addSubview(startButton)
        view.addSubview(randomStack)
        view.addSubview(changeViewColorButton)
        view.addSubview(activityIndicator)

        randomStack.addArrangedSubview(passwordLengthLable)
        randomStack.addArrangedSubview(passwordLengthSlider)
        randomStack.addArrangedSubview(randomPasswordButton)
    }

    private func setupLayout() {

        hackerImage.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(textLable.snp.top).offset(-40)
            make.height.equalTo(130)
            make.width.equalTo(130)
        }

        textLable.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(passwordTextField.snp.top).offset(-40)
            make.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(40)
        }

        randomStack.snp.makeConstraints { make in
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.height.equalTo(40)
        }

        randomPasswordButton.snp.makeConstraints { make in
            make.width.equalTo(100)
        }

        activityIndicator.snp.makeConstraints { make in
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
        }

        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(180)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }

        changeViewColorButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-40)
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }

    // MARK: - Actions

    @objc func editingChanged(_ textField: UITextField) {
        textLable.text = ""
        passwordTextField.isSecureTextEntry = true
    }

    @objc func changeViewColorButtonPressed(sender: UIButton) {
        isBlack.toggle()
    }

    @objc func startButtonPressed(sender: UIButton) {
        if passwordTextField.text != "", passwordTextField.isSecureTextEntry {
            let queue = DispatchQueue(label: "Pass", qos: .background, attributes: .concurrent)

            guard let password = passwordTextField.text else { return }

            queue.async {
                self.bruteForce(passwordToUnlock: password)
            }

            isStarted.toggle()
            activityIndicator.startAnimating()

        } else {
            textLable.text = "Введите пароль / Пароль известен"
        }
    }

    @objc func randomPasswordButtonPressed(sender: UIButton) {
        passwordTextField.isSecureTextEntry = true
        let length = Int(passwordLengthSlider.value)
        passwordTextField.text = generateRandomPass(length: length)
        textLable.text = "Сгенирирован рандомный пароль"
    }

    @objc func sliderValueDidChange(sender: UISlider) {
        let intValue = Int(sender.value)
        passwordLengthLable.text = String(intValue)
    }

    // MARK: - Logic

    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock {

            if !isStarted {
                DispatchQueue.main.async {
                    self.textLable.text = "Подбор был остановлен"
                    self.activityIndicator.stopAnimating()
                }
                return
            }

            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)

            DispatchQueue.main.async {
                self.textLable.text = password
            }
        }

        DispatchQueue.main.async {
            self.textLable.text = "Пароль взломан)"
            self.passwordTextField.isSecureTextEntry = false
            self.activityIndicator.stopAnimating()
            self.isStarted.toggle()
        }
    }

    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
        : Character("")
    }

    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }

    func generateRandomPass(length: Int) -> String {
        let base = String().printable
        var password = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            password += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }

        return password
    }
}

