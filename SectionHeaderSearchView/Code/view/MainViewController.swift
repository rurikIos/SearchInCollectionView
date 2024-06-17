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
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            self?.createSection(for: sectionIndex)
        }
    }()
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    )
    
    private lazy var dataSource = UICollectionViewDiffableDataSource<Int, CellViewModel>(
        collectionView: collectionView
    ) { [weak self] collectionView, indexPath, item in
        guard let self else {
            return UICollectionViewCell()
        }
        switch item {
        case .company(let model):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CompanyCell",
                for: indexPath
            ) as! CompanyCell
            cell.setup(model)
            return cell
        case .search:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "SearchViewCell",
                for: indexPath
            ) as! SearchViewCell
            cell.set(delegate: self)
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
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: "SearchViewCell")
    }
    
    private func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CellViewModel>()
        viewModel.models.enumerated().forEach { index, items in
            snapshot.appendSections([index])
            snapshot.appendItems(items)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func isNeedShowSearchView(for section: Int) -> Bool {
        section == 1
    }
    
    private func layout() {
        collectionView.pin.all()
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: createGroupLayout())
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
