//
//  CollectionCell.swift
//  TestTask
//
//  Created by Александр Молчан on 3.04.23.
//

import UIKit
import SnapKit

final class CollectionCell: UICollectionViewCell {
    static let id = String(describing: CollectionCell.self)
    
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(category: String) {
        contentView.addSubview(cellLabel)
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4).cgColor
        layer.cornerRadius = 15
        
        let labelInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        cellLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(labelInsets)
        }
        cellLabel.text = category
        
        if isSelected {
            self.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2).withAlphaComponent(0.2)
        } else {
            self.backgroundColor = .clear
        }
    }
    
}


