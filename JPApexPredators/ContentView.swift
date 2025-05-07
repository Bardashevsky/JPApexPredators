//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Oleksandr Bardashevskyi on 03.04.2025.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = PredatorsViewModel()

    @State var aa: ApexPredatorModel.APType = .all

    var body: some View {
        NavigationStack {
            List(viewModel.filteredPredators) { predator in
                NavigationLink {
                    PredatorDetails(predator: predator,
                                    mapCameraPosition: .camera (
                                        MapCamera(
                                            centerCoordinate: predator.location, distance: 30000
                                        )))
                } label: {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)

                        VStack(alignment: .leading) {
                            Text(predator.name)
                                .fontWeight(.bold)

                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.backgroundColor)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $viewModel.searchText)
            .autocorrectionDisabled()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            viewModel.isAlphabetical.toggle()
                        }
                    } label: {
                        Image(systemName:
                                viewModel.isAlphabetical ? "film" : "textformat"
                        )
                        .symbolEffect(.pulse, value: viewModel.isAlphabetical)
                    }
                    .fontWeight(.bold)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Picker", selection: $viewModel.selectedType.animation()) {
                            ForEach(ApexPredatorModel.APType.allCases) { type in
                                Label(type.rawValue.capitalized,
                                      systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .symbolEffect(.pulse, value: viewModel.isAlphabetical)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
