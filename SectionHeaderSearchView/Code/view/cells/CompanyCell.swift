//
//  CompanyCell.swift
//  SectionHeaderSearchView
//
//  Created by Чайков Ю.И. on 10.06.2024.
//

import UIKit
import PinLayout

final class CompanyCell: UICollectionViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "NameLabel"
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "CountLabel"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.accessibilityIdentifier = "CompanyCell"
        [nameLabel, countLabel].forEach { contentView.addSubview($0) }
        
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: CompanyCellViewModel) {
        nameLabel.text = model.name
        countLabel.text = model.count
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout()
        let height = countLabel.frame.maxY + Dimens.offset_m
        return CGSize(width: size.width, height: height)
    }
    
    private func layout() {
        countLabel.pin
            .top(Dimens.offset_m)
            .right(Dimens.offset_m)
            .sizeToFit()
        
        nameLabel.pin
            .top(Dimens.offset_m)
            .left(Dimens.offset_m)
            .left(of: countLabel)
            .sizeToFit(.width)
    }
    
}
