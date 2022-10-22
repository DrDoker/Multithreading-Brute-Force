//
//  ViewController.swift
//  Multithreading Brute force HW
//
//  Created by Serhii  on 12/10/2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - Outlets

    private lazy var textLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .red
        lable.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return lable
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter your password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .systemGray3
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemYellow
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var changeViewColorButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Color", for: .normal)
        button.backgroundColor = .systemYellow
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(changeViewColorButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupLayout()

        self.bruteForce(passwordToUnlock: "1")
    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.addSubview(textLable)
        view.addSubview(passwordTextField)
        view.addSubview(startButton)
        view.addSubview(changeViewColorButton)
    }

    private func setupLayout() {

        textLable.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-100)
        }

        passwordTextField.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }

        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(100)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }

        changeViewColorButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(170)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }

    // MARK: - Actions

    @objc func changeViewColorButtonPressed(sender: UIButton) {
        isBlack.toggle()
    }

    @objc func startButtonPressed(sender: UIButton) {
        print("startButtonPressed")
    }

    // MARK: - Logic

    var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }

    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            //             Your stuff here
            print(password)
            // Your stuff here
        }

        print(password)
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
}

