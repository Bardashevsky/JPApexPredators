//
//  PredatorDetails.swift
//  JPApexPredators
//
//  Created by Oleksandr Bardashevskyi on 09.04.2025.
//

import SwiftUI
import MapKit

struct PredatorDetails: View {
    let predator: ApexPredatorModel

    @State var mapCameraPosition: MapCameraPosition

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                .init(color: .clear, location: 0.8),
                                .init(color: .black, location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }

                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .black, radius: 7)
                        .frame(width: geo.size.width / 1.5,
                               height: geo.size.height / 3.7)
                        .scaleEffect(x: -1)
                        .offset(y: 20)
                }
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    NavigationLink {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                    } label: {
                        Map(position: $mapCameraPosition) {
                            Annotation(predator.name,
                                       coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.bounce)
                            }
                                       .annotationTitles(.hidden)

                        }
                        .frame(height: 125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "arrowshape.right.circle.fill")
                                .symbolEffect(.variableColor)
                                .imageScale(.large)
                                .font(.title3)
                                .padding()
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .font(.headline)
                                .padding(10)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }

                    Text("Appears in:")
                        .font(.title3)

                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }

                    Text("Movie moments:")
                        .font(.title)
                        .padding(.top, 15)

                    ForEach(predator.movieScenes) { scenes in
                        Text(scenes.movie)
                            .font(.title2)
                            .padding(.vertical, 1)

                        Text(scenes.sceneDescription)
                            .padding(.bottom, 15)
                    }

                    Text("Read more")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .padding(.bottom)

                }
                .padding()
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let predator = PredatorsViewModel().filteredPredators[10]

    NavigationStack {
        PredatorDetails(predator: predator,
                        mapCameraPosition: .camera (
                            MapCamera(
                                centerCoordinate: predator.location, distance: 30000
                            )
                        )
        )
        .preferredColorScheme(.dark)
    }
}
