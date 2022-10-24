//
//  BruteForce.swift
//  Multithreading Brute force HW
//
//  Created by Serhii  on 24/10/2022.
//

import Foundation

struct BrutePasswordHelp {
    static let shared = BrutePasswordHelp()

    private init() {}

    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character)) ?? 0
    }

    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")
    }

    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var initialPasswordString: String = string

        if initialPasswordString.count <= 0 {
            initialPasswordString.append(characterAt(index: 0, array))
        } else {
            let symbol = characterAt(index: (indexOf(character: initialPasswordString.last ?? Character(""), array) + 1) % array.count, array)
            initialPasswordString.replace(at: initialPasswordString.count - 1, with: symbol)

            if indexOf(character: initialPasswordString.last ?? Character(""), array) == 0 {
                initialPasswordString = String(generateBruteForce(String(initialPasswordString.dropLast()), fromArray: array)) + String(initialPasswordString.last ?? Character(""))
            }
        }

        return initialPasswordString
    }

    func generateRandomPassword(length: Int) -> String {
        let base = String().printable
        var password = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            password += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }

        return password
    }
}
