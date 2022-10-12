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

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Кнопка", for: .normal)
        button.backgroundColor = .systemYellow
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
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
        view.addSubview(button)
    }

    private func setupLayout() {
        button.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
    }

    // MARK: - Actions

    @objc func buttonPressed(sender: UIButton) {
        isBlack.toggle()
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

