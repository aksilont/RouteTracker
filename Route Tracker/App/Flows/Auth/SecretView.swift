//
//  SecretView.swift
//  Route Tracker
//
//  Created by Aksilont on 15.04.2021.
//

import UIKit

class SecretView: UIView {
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Route Tracker"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 40.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .systemTeal
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
