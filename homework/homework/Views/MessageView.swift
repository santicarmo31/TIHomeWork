//
//  MessageView.swift
//  homework
//
//  Created by Santiago Carmona on 27/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import UIKit

class MessageView: UIView {
    private enum Constants {
        static let spacing: CGFloat = 20
    }

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    init(message: String = "", frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .white
        messageLabel.text = message
        messageLabel.textAlignment = .center
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.spacing),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing),
            trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: Constants.spacing),
            bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Constants.spacing)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(message: String) {
        messageLabel.text = message
    }
}
