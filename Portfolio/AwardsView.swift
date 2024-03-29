//
//  AwardsView.swift
//  Portfolio
//
//  Created by Rob on 02/11/2021.
//

import SwiftUI

struct AwardsView: View {
    @EnvironmentObject var dataController: DataController
    @State private var selectedAward = Award.example
    @State private var showingAwardDetails = false

    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }

    static let tag: String? = "Awards"

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            selectedAward = award
                            showingAwardDetails = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(color(for: selectedAward))
                        }
                    }
                }
            }
            .navigationTitle("Awards")
            .alert(isPresented: $showingAwardDetails, content: getAwardAlert)
            .accessibilityLabel(label(for: selectedAward))
            .accessibilityHint(Text(selectedAward.description))
        }
    }

    func color(for award: Award) -> Color {
        dataController.hasEarned(award: award) ? Color(award.color) : .secondary.opacity(0.5)
    }

    func label(for award: Award) -> Text {
        Text(dataController.hasEarned(award: selectedAward) ? "Unlocked: \(selectedAward.name)" : "Locked")
    }

    func getAwardAlert() -> Alert {
        if dataController.hasEarned(award: selectedAward) {
            return Alert(title: Text("Unlocked: \(selectedAward.name)"),
                         message: Text(selectedAward.description),
                         dismissButton: .default(Text("OK")))
        } else {
            return Alert(title: Text("Locked"),
                         message: Text(selectedAward.description),
                         dismissButton: .default(Text("OK")))
        }
    }
}
