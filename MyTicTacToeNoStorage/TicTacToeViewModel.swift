//
//  TicTacToeViewModel.swift
//  MyTicTacToeNoStorage
//
//  Created by radhika sharma on 2/21/24.
//

import Foundation
import SwiftUI

enum Player: String {
    case O
    case X
    case E
    
    var color: Color {
        switch self {
        case .O:
            return .red
        case .X:
            return .blue
        case .E:
            return .clear
        }
    }
    
    var buttonText: String {
        switch self {
        case .O, .X:
            return self.rawValue
        case .E:
            return ""
        }
    }
    
    var player: String {
        switch self {
        case .O, .X:
            return self.rawValue
        case .E:
            return "X"
        }
    }
}

class TicTacToeViewModel: ObservableObject {
    @Published  var currentPlayer: Player = .E
    @Published  var cells: [[Player]] = Array(repeating: Array(repeating: .E, count: 3), count: 3)
    @Published var winner: Player? = nil
    @Published var draw: Bool = false
    
    @Published var turnText: String = "Player X's turn"
    
    var messageColor: Color = .blue

    func move(row: Int, column: Int, player: Player) -> (winner: Bool, draw: Bool) {
        guard cells[row][column] == .E else {
            return (false, true)
        }
        
        cells[row][column] = player
        currentPlayer = player == .X ? .O : .X
        
        turnText = "Player \(currentPlayer.player)'s turn"
        
        if isWinner(row: row, column: column, player: player) {
            winner = player
            messageColor = .orange
            turnText = "Player \(player.player) won this round"
            return (true, false)
        }
        
        if isDraw() {
            winner = nil
            messageColor = .green
            turnText = "Its a draw, try again"
            return (false, true)
        }
        
        return (false, false)
    }
    
    func isWinner(row: Int, column: Int, player: Player) -> Bool {
        
        //Check row or column
        if (((cells[row][0] == player) && (cells[row][1] == player) && (cells[row][2] == player)) || ((cells[0][column] == player) && (cells[1][column] == player) && (cells[2][column] == player))) {
            return true
        }
        
        //Check diagonal
        if (((cells[0][0] == player) && (cells[1][1] == player) && (cells[2][2] == player)) || ((cells[1][1] == player) && (cells[0][2] == player) && (cells[2][0] == player))) {
            return true
        }
        
        return false
    }
    
    func isDraw() -> Bool {
        var emptyCells = [Player]()
        for i in 0..<3 {
            let empty = cells[i].filter({ $0 == .E})
            if empty.count > 0 {
                emptyCells.append(contentsOf: empty)
            }
        }
        draw = (emptyCells.count == 0)
        return draw
    }
    
    func reset() {
        currentPlayer = .E
        winner = nil
        turnText = "Player X's turn"
        cells = Array(repeating: Array(repeating: .E, count: 3), count: 3)
    }
    
}
