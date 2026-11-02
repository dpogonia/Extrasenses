//
//  ContentView.swift
//  OTUS SUI Project
//
//  Created by Dmitrii Pogonia on 12.03.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Выберите режим") {
                    NavigationLink {
                        RickAndMortyTabsView()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "atom")
                                .foregroundStyle(.green)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Rick and Morty")
                                    .font(.headline)
                                Text("Список персонажей и случайный герой")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }

                    NavigationLink {
                        PsychicTabsView()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "sparkles")
                                .foregroundStyle(.purple)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Странные экстрасенсы")
                                    .font(.headline)
                                Text("Карточки с описанием экстрасенсов")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Выбор вселенной")
        }
    }
}

#Preview {
    ContentView()
}
