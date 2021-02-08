//
//  VenuesTableViewCell.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import UIKit

class VenuesTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = NSStringFromClass(VenuesTableViewCell.self)
    
    private let IconSize: CGFloat = 20
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 21)
        return label
    }()
    
    lazy var locationIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ic_location")
        return imageView
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var distanceIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ic_distance")
        return imageView
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        [titleLabel, locationIconImageView, locationLabel, distanceIconImageView, distanceLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        locationIconImageView.heightAnchor.constraint(equalToConstant: IconSize).isActive = true
        locationIconImageView.widthAnchor.constraint(equalToConstant: IconSize).isActive = true
        locationIconImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        locationIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        locationLabel.centerYAnchor.constraint(equalTo: locationIconImageView.centerYAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationIconImageView.trailingAnchor, constant: 10).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        distanceIconImageView.heightAnchor.constraint(equalToConstant: IconSize).isActive = true
        distanceIconImageView.widthAnchor.constraint(equalToConstant: IconSize).isActive = true
        distanceIconImageView.topAnchor.constraint(equalTo: locationIconImageView.bottomAnchor, constant: 10).isActive = true
        distanceIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        distanceIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        distanceLabel.centerYAnchor.constraint(equalTo: distanceIconImageView.centerYAnchor).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: distanceIconImageView.trailingAnchor, constant: 10).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    func configure(model: VenueModel) {
        titleLabel.text = model.name
        locationLabel.text = model.location
        distanceLabel.text = model.distance
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
