//
//  SearchViewSupplementaryItem.swift
//  SectionHeaderSearchView
//
//  Created by Чайков Ю.И. on 10.06.2024.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func search(newText: String)
    func didEndEditing()
}

final class SearchViewSupplementaryItem: UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
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
        accessibilityIdentifier = "SearchViewSupplementaryItem"
        backgroundColor = .lightGray
        addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func set(delegate: SearchViewDelegate) {
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.pin.all()
    }
    
    @objc private func textFieldValueDidChange() {
        delegate?.search(newText: textField.text ?? "")
    }
    
}

extension SearchViewSupplementaryItem: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing()
    }
    
}
