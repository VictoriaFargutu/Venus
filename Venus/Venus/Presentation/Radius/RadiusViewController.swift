//
//  RadiusViewController.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import UIKit

protocol RadiusViewControllerDelegate: AnyObject {
    func radiusViewControllerDidCancel(_ controller: RadiusViewController)
    func radiusViewControllerDidSelect(_ controller: RadiusViewController, newRadius: Int?)
}

class RadiusViewController: UIViewController {
    private var contentView: RadiusView = {
       return RadiusView()
    }()

    private let currentRadius: Int
    weak var delegate: RadiusViewControllerDelegate?

    init(currentRadius: Int) {
        self.currentRadius = currentRadius
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()
        view = contentView
        contentView.radiusTextField.text = String(currentRadius)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.dimView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissController)))
        contentView.okButton.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
        contentView.cancelButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    }
    
    @objc
    private func didTapOkButton() {
        delegate?.radiusViewControllerDidSelect(self, newRadius: Int(contentView.radiusTextField.text ?? "0"))
    }

    @objc
    private func dismissController() {
        delegate?.radiusViewControllerDidCancel(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
