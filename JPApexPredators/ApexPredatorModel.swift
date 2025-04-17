//
//  ApexPredatorModel.swift
//  JPApexPredators
//
//  Created by Oleksandr Bardashevskyi on 03.04.2025.
//

import SwiftUI
import MapKit

struct ApexPredatorModel: Decodable, Identifiable {
    
    enum APType: String, Decodable, CaseIterable, Identifiable {
        var id: APType {
            self
        }

        case all
        case land
        case air
        case sea

        var backgroundColor: Color {
            switch self {
            case .land:
                return .brown
            case .air:
                return .green
            case .sea:
                return .blue
            case .all:
                return .black
            } 
        }

        var icon: String {
            switch self {
            case .air: 
                "wind"
            case .all:
                "square.stack.3d.up.fill"
            case .land:
                "leaf.fill"
            case .sea: 
                "drop.fill"
            }
        }
    }

    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String

    var image: String {
        return name.lowercased().replacingOccurrences(of: " ", with: "")
    }

    var location: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}

extension ApexPredatorModel {
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}
