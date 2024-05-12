//
//  ViewController.swift
//  CardFlip
//
//  Created by Smart Castle M1A2009 on 26.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    
    var buttonArray = [UIButton]()
    
    // MARK: control + command + пробел
    var emojiArray = ["😀", "😃", "😄", "😁", "😆", "🥹", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😀", "😃", "😄", "😁", "😆", "🥹", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉"].shuffled()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "Emoji"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignals()
        setupUI()
    }
    
    func setupSignals() {
        for emoji in emojiArray {
            let button = makebutton(text: emoji)
            buttonArray.append(button)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(countLabel)
        countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        countLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        countLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        var horizontalStackViews = [UIStackView]()
        
        for i in stride(from: 0, to: 32, by: 4) {
            let stackView = makeHorizontalStackView(views: Array(buttonArray[i...(i + 3)]))
            stackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            horizontalStackViews.append(stackView)
            
        }
        
        let verticalStackView = UIStackView(arrangedSubviews: horizontalStackViews)
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 10
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(verticalStackView)
        verticalStackView.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 20).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
    }
    
    func makebutton(text: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setTitle(text, for: .selected)
        button.addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
        return button
    }
    
    func makeHorizontalStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    var successScore = 0
    var currentOpenedCard = 0
    var openedCardId = [UIButton]()
    
    @objc func handleButtonPressed(button: UIButton) {
        
        if currentOpenedCard < 2 {
            currentOpenedCard += 1
            openedCardId.append(button)
            
            if openedCardId.count == 2 {
                if openedCardId[0].title(for: .selected)! == openedCardId[1].title(for: .selected)! {
                    if openedCardId[0] != openedCardId[1] {
                        openedCardId[0].alpha = 0
                        openedCardId[1].alpha = 0
                    }
                } else {
                    buttonArray.forEach { button in
                      //  button.isSelected = false
                    }
                }
            }
            
            
        } else if currentOpenedCard == 2 {
            
            if openedCardId[0].title(for: .selected)! == openedCardId[1].title(for: .selected)! {
                if openedCardId[0] != openedCardId[1] {
                    openedCardId[0].alpha = 0
                    openedCardId[1].alpha = 0
                    successScore += 1
                    self.countLabel.text = String(successScore)
                }
            }
            openedCardId.removeAll()
            currentOpenedCard = 1
            openedCardId.append(button)
            
            //           buttonArray.forEach({ $0.isSelected = false})
            
            buttonArray.forEach { button in
                button.isSelected = false
            }
            
        }
        
        button.isSelected.toggle()
        
    }
}

        
        // MARK: - SwiftUI
        import SwiftUI
        @available(iOS 13.0, *)
        struct MainVCProvider: PreviewProvider {
            static var previews: some View {
                ContainerView().edgesIgnoringSafeArea(.all)
            }
            
            struct ContainerView: UIViewControllerRepresentable {
                func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
                    
                }
                
                let mainVC = MainViewController()
                func makeUIViewController(context: UIViewControllerRepresentableContext<MainVCProvider.ContainerView>) -> MainViewController {
                    return mainVC
                }
                
            }
        }
