//
//  RadiusView.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import UIKit

class RadiusView: UIView {
    
    lazy var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)
        return view
    }()

    lazy var modalView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 3
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.text = NSLocalizedString("You can edit the radius to search within, in meters. The current one is displayed below.", comment: "")
        return label
    }()
    
    lazy var radiusTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.isSelected = true
        return textField
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("OK", comment: ""), for: .normal)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [dimView, modalView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        dimView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dimView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dimView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        dimView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        modalView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.80).isActive = true
        modalView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        modalView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
        
        [titleLabel, radiusTextField, okButton, cancelButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            modalView.addSubview($0)
        }
        
        titleLabel.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -15).isActive = true
        
        radiusTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        radiusTextField.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 15).isActive = true
        radiusTextField.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -15).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: radiusTextField.bottomAnchor, constant: 10).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 25).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -20).isActive = true
        
        okButton.topAnchor.constraint(equalTo: cancelButton.topAnchor).isActive = true
        okButton.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -25).isActive = true
        okButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
