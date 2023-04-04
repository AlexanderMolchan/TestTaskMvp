//
//  TableCell.swift
//  TestTask
//
//  Created by Александр Молчан on 3.04.23.
//

import UIKit
import SnapKit
import SDWebImage

final class TableCell: UITableViewCell {
    static let id = String(describing: TableCell.self)
    
    private lazy var cellImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
     lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 3
        label.textColor = UIColor(red: 0.665, green: 0.668, blue: 0.679, alpha: 1)
        return label
    }()
    
    private lazy var priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor
        button.layer.cornerRadius = 6
        return button
    }()
    
    var model: TotalFoodModel
    
    init(model: TotalFoodModel) {
        self.model = model
        super.init(style: .default, reuseIdentifier: TableCell.id)
        layoutElements()
        makeConstraints()
        configurate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        contentView.addSubview(cellImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(priceButton)
    }
    
    private func makeConstraints() {
        let imageInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        cellImage.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(imageInsets)
            make.height.width.equalTo(132)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(cellImage.snp.trailing).inset(-32)
            make.trailing.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(32)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-8)
            make.leading.equalTo(cellImage.snp.trailing).inset(-32)
            make.trailing.equalToSuperview().inset(24)
        }
        
        priceButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(32)
            make.width.equalTo(87)
        }
    }
    
    private func configurate() {
        selectionStyle = .none
        cellImage.sd_setImage(with: URL(string: model.imageUrl))
        titleLabel.text = model.name
        infoLabel.text = "Information is temporarily unavailable"
        let randomPrice = Int.random(in: 10...20)
        priceButton.setTitle("\(randomPrice)$", for: .normal)
    }
    
}
