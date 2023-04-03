//
//  BannerCollectionCell.swift
//  TestTask
//
//  Created by Александр Молчан on 3.04.23.
//

import UIKit
import SnapKit

final class BannerCollectionCell: UICollectionViewCell {
    static let id = String(describing: BannerCollectionCell.self)
    
    lazy var cellImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "NewBanner")
        clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        contentView.addSubview(cellImage)
        cellImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        layer.cornerRadius = 10
    }
    
}
