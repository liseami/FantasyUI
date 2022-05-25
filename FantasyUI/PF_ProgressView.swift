//
//  PF_NavigationView.swift
//  FantasyUI
//
//  Created by 赵翔宇 on 2021/12/30.
//

import SwiftUI

public enum PF_LoadingState {
    case none
    case fullScreen
    case block
    case simple
}

struct PF_NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Color.gray.ignoresSafeArea()
            Text("some View")
        }
        .PF_OverProgressView(loadingState: .block)
    }
}

public extension View {
    func PF_OverProgressView(loadingState: PF_LoadingState = .fullScreen) -> some View {
        let block = BlurView()
            .frame(width: SCREEN_WIDTH / 2.5, height: SCREEN_WIDTH / 2.5)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        return overlay(
            Group {
                switch loadingState {
                case .none: EmptyView()

                case .block:
                    block
                        .overlay(VStack(spacing: 12) {
                            ProgressView()
                                .scaleEffect(1.6)
                        }
                        .padding(.all, 12))

                case .fullScreen:
                    ZStack {
                        HStack {
                            FantasyWaveView()
                                .scaleEffect(3)
                                .rotationEffect(Angle(degrees: 90))
                            FantasyWaveView()
                                .scaleEffect(3)
                                .rotationEffect(Angle(degrees: 90))
                            FantasyWaveView()
                                .scaleEffect(3)
                                .rotationEffect(Angle(degrees: 90))
                        }

                        BlurView()
                            .ignoresSafeArea()
                            .overlay(ProgressView().scaleEffect(1.6))
                    }

                case .simple: ProgressView()
                }
            })
    }
}
