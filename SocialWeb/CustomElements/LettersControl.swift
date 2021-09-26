//
//  LettersControl.swift
//  SocialWeb
//
//  Created by Никитка on 25.07.2021.
//

import UIKit

class LettersControl: UIControl {
    
    var selectedLetter: String? = nil {
        didSet{
            self.sendActions(for: .valueChanged)
        }
    }
    
    private var letters = [String]() {
        didSet{
            setup()
        }
    }
    
    private var buttons = [UIButton]()
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    func setLetters(_ letters: [String]) {
        self.letters = letters
    }
    
    private func setup() {
        for letter in letters {
            let button = UIButton(type: .system)
            button.backgroundColor = .clear
            button.setTitle(letter, for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 14)
            button.addTarget(self, action: #selector(selectedLetter(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    private func clearStack() {
        self.buttons = []
    }
    
    @objc private func selectedLetter(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender)
        else { return }
        
        self.selectedLetter = letters[index]
    }
}
