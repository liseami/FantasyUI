// 
//  WaveData.swift
//
//  Created by Den Jo on 2021/04/05.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

final class WaveData: ObservableObject {
    
    // MARK: - Value
    // MARK: Public
    @Published var waves = Array(repeating: Wave(power: 0), count: 8)
    let colors = [Color(#colorLiteral(red: 0, green: 0.7445259094, blue: 0.981395781, alpha: 1)),Color(#colorLiteral(red: 0.9351609945, green: 0.09165553004, blue: 0.4444091916, alpha: 1)),Color(#colorLiteral(red: 0.9971383214, green: 0.4211875796, blue: 0.2124275863, alpha: 1)),Color(#colorLiteral(red: 0.9577248693, green: 0.6975020766, blue: 0.2912349999, alpha: 1)),Color(#colorLiteral(red: 0.02263502218, green: 0.7266353965, blue: 0.4803205132, alpha: 1)),Color(#colorLiteral(red: 0.7707241178, green: 0.06197594851, blue: 0.8179481626, alpha: 1)),Color(#colorLiteral(red: 0.001365645556, green: 0.0666840896, blue: 0.2859631777, alpha: 1))]
    
    
  
    
    // MARK: - Function
    // MARK: Public
    func update(power: CGFloat) {
        waves = colors.map { _ in Wave(power: power) }
    }
}
