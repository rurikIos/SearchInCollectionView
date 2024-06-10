//
//  MainViewController.swift
//  SectionHeaderSearchView
//
//  Created by Чайков Ю.И. on 10.06.2024.
//

import UIKit
import PinLayout

final class MainViewController: UIViewController {
    
    private var viewModel = ViewModel()
    private var searchText = ""
    
    private var collectionViewLayout: UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            self?.createSection(for: sectionIndex)
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        if let delegate = self as? UICollectionViewDelegate {
            collectionView.delegate = delegate
        }
        
        if let dataSource = self as? UICollectionViewDataSource {
            collectionView.dataSource = dataSource
        }
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        update()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        collectionView.register(CompanyCell.self, forCellWithReuseIdentifier: "CompanyCell")
        collectionView.register(RequestCell.self, forCellWithReuseIdentifier: "RequestCell")
        
        collectionView.register(
            SearchViewSupplementaryItem.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchViewSupplementaryItem.identifier
        )
    }
    
    private func update() {
        if searchText.isEmpty {
            collectionView.reloadData()
        } else {
            let lastSectionNumber = viewModel.models.count - 1
            collectionView.reloadSections([lastSectionNumber])
        }
        
    }
    
    private func isNeedShowSearchView(for section: Int) -> Bool {
        section == 1
    }
    
    private func layout() {
        collectionView.pin.all()
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: createGroupLayout())
        
        if isNeedShowSearchView(for: sectionIndex) {
            let searchViewSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(Dimens.inlineHeight_xs)
            )
            let searchViewSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: searchViewSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems.append(searchViewSupplementary)
        }
        
        return section
    }
    
    private func createGroupLayout() -> NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Dimens.inlineHeight_default)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [])

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Dimens.inlineHeight_default)
        )
        return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.models[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.models[indexPath.section][indexPath.item]
        switch item {
        case .company(let model):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CompanyCell",
                for: indexPath
            ) as! CompanyCell
            cell.setup(model)
            return cell
        case .request(let model):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RequestCell",
                for: indexPath
            ) as! RequestCell
            cell.setup(model)
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let searchInput = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: String(describing: SearchViewSupplementaryItem.self),
                for: indexPath
            ) as? SearchViewSupplementaryItem else {
                fatalError(
                    "faled deque supplementary"
                )
            }
            searchInput.set(delegate: self)
            return searchInput
        default:
            fatalError("unknown supplementary element")
        }
    }
}

extension MainViewController: SearchViewDelegate {
    
    func search(newText: String) {
        print("search: \(newText)")
        guard newText.count >= 3 else {
            return
        }
        searchText = newText
        viewModel.search(newText)
        update()
    }
    
    func didEndEditing() {
        print("didEndEditing")
    }
    
}
