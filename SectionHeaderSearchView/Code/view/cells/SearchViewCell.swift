//
//  SearchViewCell.swift
//  SectionHeaderSearchView
//
//  Created by Чайков Ю.И. on 10.06.2024.
//

import UIKit
import PinLayout

protocol SearchViewDelegate: AnyObject {
    
    func search(newText: String)
    func didEndEditing()
    
}

final class SearchViewCell: UICollectionViewCell {
    
    weak var delegate: SearchViewDelegate?
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(textFieldValueDidChange), for: .editingChanged)
        textField.autocorrectionType = .no
        textField.returnKeyType = .search
        textField.delegate = self
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.accessibilityIdentifier = "SearchViewCell"
        backgroundColor = .lightGray
        contentView.addSubview(textField)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(delegate: SearchViewDelegate) {
        self.delegate = delegate
    }
    
    @objc private func textFieldValueDidChange() {
        delegate?.search(newText: textField.text ?? "")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: Dimens.inlineHeight_xs)
    }
    
    private func layout() {
        textField.pin.all()
    }
}

extension SearchViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing()
    }
    
}
