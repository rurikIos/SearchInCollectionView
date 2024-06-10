//
//  ViewModel.swift
//  SectionHeaderSearchView
//
//  Created by Чайков Ю.И. on 10.06.2024.
//

final class ViewModel {
    
    var models: [[CellViewModel]] {
        [
            companyModels,
            [.search],
            searchText.isEmpty ? requestModels : requestModels.filter { model in
                switch model {
                case .company, .search:
                    false
                case .request(let model):
                    model.companyName.contains(searchText)
                }
            }
        ]
    }
    
    private var companyModels: [CellViewModel] = [
        .company(CompanyCellViewModel(name: "НРОО Клуб Умный Пес", count: "110")),
        .company(CompanyCellViewModel(name: "Камбоджа, ООО", count: "0")),
        .company(CompanyCellViewModel(name: "Максимов Олег Игоревич, ИП", count: "0")),
        .company(CompanyCellViewModel(name: "Егорова Мария, ИП", count: "0")),
        .company(CompanyCellViewModel(name: "Дедич Эдин, ИП", count: "50"))
    ]
    
    private var requestModels: [CellViewModel] = [
        .request(RequestCellViewModel(companyName: "Евротранссервис+", requestName: "Аренда помещений", cost: "10")),
        .request(RequestCellViewModel(companyName: "008 Телеком", requestName: "Оплата поставщику", cost: "700")),
        .request(RequestCellViewModel(companyName: "008 Телеком", requestName: "Оплата поставщику", cost: "600")),
        .request(RequestCellViewModel(companyName: "Евротранссервис+", requestName: "Аренда помещений", cost: "10")),
        .request(RequestCellViewModel(companyName: "Евротранссервис+", requestName: "Аренда помещений", cost: "20")),
        .request(RequestCellViewModel(companyName: "Евротранссервис+", requestName: "Аренда помещений", cost: "40"))
    ]
    
    private var searchText = ""
    
    func search(_ searchText: String) {
        self.searchText = searchText
    }
    
}
