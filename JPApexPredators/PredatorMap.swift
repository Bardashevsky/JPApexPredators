//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Oleksandr Bardashevskyi on 29.04.2025.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predatorsViewModel = PredatorsViewModel()

    @State var position: MapCameraPosition
    @State var isSetalite: Bool = false

    var body: some View {
        Map(position: $position) {
            ForEach(predatorsViewModel.filteredPredators) { predator in
                Annotation(predator.name,coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(isSetalite ? .imagery(elevation: .realistic) : .standard)
        .overlay(alignment: .bottomTrailing) {
            Button {
                isSetalite.toggle()
            } label: {
                Image(systemName: isSetalite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .padding()
            }

        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(
        MapCamera(
            centerCoordinate: PredatorsViewModel().filteredPredators[2].location,
            distance: 1000,
            heading: 250,
            pitch: 80
        )))
    .preferredColorScheme(.dark)
}
