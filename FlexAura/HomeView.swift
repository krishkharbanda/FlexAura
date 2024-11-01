//
//  HomeView.swift
//  FlexAura
//
//  Created by Krish on 10/30/24.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: VMs
    @EnvironmentObject var habitat: Habitat
    @StateObject private var viewModel = HomeViewModel()
    
    // MARK: vars
    
    // MARK: body
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.black.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        Spacer(minLength: Constants.navigationBarHeight).frame(width: geometry.size.width, height: Constants.navigationBarHeight, alignment: .top)
                        self.createRings()
                        self.createFooter()
                    }
                }
                self.createNavigationBar(geometry.size)
            }
        }
    }
    
    func createRings() -> some View {
        ZStack {
            RingView(
                percentage: ActivityData.ringsPercentage.movePercentage,
                backgroundColor: Color.moveRingBackground,
                startColor: Color.moveRingStartColor,
                endColor: Color.moveRingEndColor,
                thickness: Constants.mainRingThickness
            )
                .frame(width: 280, height: 280)
                .aspectRatio(contentMode: .fit)
            Text(String(Int(ActivityData.ringsPercentage.movePercentage * 100)) + "º")
                .font(.largeTitle)
                .bold()
        }
    }
    
    func createNavigationBar(_ geometrySize: CGSize) -> some View {
        ZStack(alignment: .top) {
            BlurView(style: .dark).edgesIgnoringSafeArea(.top)
            VStack {
                HStack {
                    ForEach(0..<ActivityData.weekdays.count) { item in
                        VStack(spacing: 5) {
                            Text("\(ActivityData.weekdays[item].firstLetter)")
                                .font(Font.system(size: 10, weight: .regular, design: .default))
                                .foregroundColor(Color.white)
                            ZStack {
                                RingView(
                                    percentage: ActivityData.weekdays[item].movePercentage,
                                    backgroundColor: Color.moveRingWeekdayBackground,
                                    startColor: Color.moveRingStartColor,
                                    endColor: Color.moveRingEndColor,
                                    thickness: Constants.weekdayRingThickness
                                )
                                    .frame(width: 40, height: 40)
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                }
            }
        }
            .frame(width: geometrySize.width, height: Constants.navigationBarHeight, alignment: .top)
    }
    
    func createFooter() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 60) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Range of Motion")
                        .font(Font.system(size: 18, weight: .regular, design: .default))
                        .kerning(0.05)
                        .foregroundColor(Color.white)
                    Text(String(Int(ActivityData.ringsPercentage.movePercentage * 100)) + "/120")
                        .font(Font.system(size: 28, weight: .semibold, design: .rounded))
                        .kerning(0.25)
                        .foregroundColor(Color.activityValueText)
                        .padding([.top], -3)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Percentage").font(Font.system(size: 18, weight: .regular, design: .default)).kerning(0.05).foregroundColor(Color.white)
                    (
                        Text(String(Int((ActivityData.ringsPercentage.movePercentage / 120.0) * 100)))
                            .font(Font.system(size: 28, weight: .semibold, design: .rounded))
                            .kerning(0.25)
                            .foregroundColor(Color.activityValueText)
                        + Text("º")
                            .font(Font.system(size: 24, weight: .semibold, design: .rounded))
                            .kerning(0.3).foregroundColor(Color.activityValueText)
                    )
                        .padding([.top], -3)
                }
                Spacer()
            }
            Divider()
                .background(Color.dividerBackground)
                .frame(height: 2)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 15, trailing: 0))
            }
            .padding([.leading], 15)
    }
}

#Preview {
    HomeView()
}
