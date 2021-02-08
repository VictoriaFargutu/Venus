//
//  VenuesView.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import UIKit

class VenuesView: UIView {
    
    lazy var venuesTableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tableView.separatorInset = .zero
        tableView.isHidden = true
        return tableView
    }()
    
    lazy var loadingVenuesLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.text = NSLocalizedString("Loading venues...", comment: "")
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var noVenuesFoundLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.text = NSLocalizedString("No venues found.", comment: "")
        label.font = .boldSystemFont(ofSize: 25)
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        [venuesTableView, loadingVenuesLabel, noVenuesFoundLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        venuesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        venuesTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        venuesTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        venuesTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        loadingVenuesLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingVenuesLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
        noVenuesFoundLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        noVenuesFoundLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
