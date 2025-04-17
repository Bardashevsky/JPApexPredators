//
//  PredatorsViewModel.swift
//  JPApexPredators
//
//  Created by Oleksandr Bardashevskyi on 07.04.2025.
//

import Foundation
import Combine

class PredatorsViewModel: ObservableObject {
    @Published var filteredPredators: [ApexPredatorModel] = []

    @Published var isAlphabetical = false {
        didSet {
            isSorted(by: isAlphabetical)
        }
    }

    @Published var searchText: String = "" {
        didSet {
            search(text: searchText)
        }
    }

    @Published var selectedType: ApexPredatorModel.APType = .all {
        didSet {
            filter(by: selectedType)
        }
    }

    private var originPredators: [ApexPredatorModel]

    init() {
        self.originPredators = Self.loadPredators()
        self.filteredPredators = self.originPredators
    }

    //MARK: - Public func -
    func search(text: String) {
        if !text.isEmpty {
            filteredPredators = originPredators.filter {
                $0.name.localizedStandardContains(text) && $0.type == selectedType
            }
        } else {
            filter(by: selectedType)
        }
    }

    func isSorted(by alphabet: Bool) {
        filteredPredators.sort {
            alphabet ? $0.name < $1.name : $0.id < $1.id
        }

        originPredators.sort {
            alphabet ? $0.name < $1.name : $0.id < $1.id
        }
    }

    func filter(by type: ApexPredatorModel.APType) {
        if type != .all {
            filteredPredators = originPredators.filter { $0.type == type }
        } else {
            filteredPredators = originPredators
        }
    }

    //MARK: - Private func -
    private static func loadPredators() -> [ApexPredatorModel] {
        guard let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") else {
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode([ApexPredatorModel].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
