//
//  DayProgressCard.swift
//  Medora
//
//  Created by Govine Rajput on 31/10/26.
//

import SwiftUI

struct DayProgressCard: View {
    
    let noOfDosesTaken: Int
    let totalNoOfDoses: Int
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Today's Progress")
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                
                //no of daily doses and no of doses taken
                HStack {
                    Text("\(noOfDosesTaken) of \(totalNoOfDoses)")
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(.white)
                    
                    Text("doses taken")
                        .font(.system(size: 18))
                        .foregroundStyle(.white)
                    
                }
                
                //straight progress indicator for today's does taken indication
                StraightProgressIndicator()
            }
            
            Spacer()
            
            //circular progress Indicator to track no of doses remaining
            CirculatProgressIndicator()
            
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(.themeAccent)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
    }
}

#Preview {
    
    VStack {
        DayProgressCard(
            noOfDosesTaken: 2,
            totalNoOfDoses: 3
        )
    }
    .padding(.horizontal, 24)
    .padding(.top, 32)
    .padding(.bottom, 24)
    .frame(maxWidth: 500)
    .frame(maxWidth: .infinity)
}
