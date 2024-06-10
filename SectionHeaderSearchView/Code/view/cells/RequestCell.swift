//
//  RequestCell.swift
//  SectionHeaderSearchView
//
//  Created by Чайков Ю.И. on 10.06.2024.
//

import UIKit
import PinLayout

final class RequestCell: UICollectionViewCell {
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "CompanyNameLabel"
        return label
    }()
    
    private let requestNameLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "RequestNameLabel"
        return label
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "CostLabel"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.accessibilityIdentifier = "RequestCell"
        [companyNameLabel, requestNameLabel, costLabel].forEach { contentView.addSubview($0) }
        
        contentView.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: RequestCellViewModel) {
        companyNameLabel.text = model.companyName
        requestNameLabel.text = model.requestName
        costLabel.text = model.cost
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout()
        let height = costLabel.frame.maxY + Dimens.offset_m
        return CGSize(width: size.width, height: height)
    }
    
    private func layout() {
        companyNameLabel.pin
            .top(Dimens.offset_m)
            .horizontally(Dimens.offset_m)
            .sizeToFit()
        
        costLabel.pin
            .below(of: companyNameLabel)
            .marginTop(Dimens.offset_m)
            .right(Dimens.offset_m)
            .sizeToFit()
        
        requestNameLabel.pin
            .below(of: companyNameLabel)
            .marginTop(Dimens.offset_m)
            .left(Dimens.offset_m)
            .left(of: costLabel)
            .marginRight(Dimens.offset_m)
            .sizeToFit(.width)
    }
}
