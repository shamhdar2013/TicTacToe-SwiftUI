//
//  ContentView.swift
//  MyTicTacToeNoStorage
//
//  Created by radhika sharma on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TicTacToeViewModel()
   
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                
                VStack(spacing: 20.0){
                    Text("Let's Play Tic Tac Toe")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                        Spacer()
                        Button(action: {
                            viewModel.reset()
                        } , label: {
                                Text("Reset Game")
                                    .font(.title)
                        }).background(Color(red: 0, green: 0, blue: 0.5))
                        .foregroundStyle(.white)
                        .buttonStyle(.bordered)
                }.padding(.top, 60.0)
                
                Text(viewModel.turnText)
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(viewModel.messageColor)
                            .padding(.top, 20.0)
                            .padding(.bottom, 20.0)
                Spacer()
                
                Grid(horizontalSpacing: 5.0, verticalSpacing: 5.0) {
                    ForEach (0..<3) { row in
                        GridRow {
                            ForEach (0..<3) {col in
                                Button(action: {
                                    let player: Player = viewModel.currentPlayer == .E ? .X : viewModel.currentPlayer
                                    _ = viewModel.move(row: row, column:col, player: player)
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(.gray)
                                            .frame(width: 80, height: 80)
                                            .shadow(radius: 5)
                                        Text("\(viewModel.cells[row][col].buttonText)")
                                            .foregroundColor(viewModel.cells[row][col].color)
                                            .font(.title)
                                            .fontWeight(.bold)
                                    }
                                })
                                .disabled(((viewModel.winner != nil) || viewModel.draw))
                            }
                        }
                    }
                }
            }.frame(width: proxy.size.width, height: (proxy.size.height / 2.0))
        } .safeAreaPadding(.vertical, 60.0)
    }
}

#Preview {
    ContentView()
}
