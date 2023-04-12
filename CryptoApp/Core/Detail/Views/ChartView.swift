//
//  ChartView.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 1/23/1402 AP.
//

import SwiftUI

struct ChartView: View {
    
    private let data : [Double]
    private let maxY : Double
    private let minY : Double
    private let lineColor : Color
    private let startingDate : Date
    private let endingDate : Date
    @State private var percentage : CGFloat = 0
    
    init(coin:CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.thems.green : Color.thems.red
        
        endingDate = Date(coinGekoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack(spacing:10){
            chartView
                .frame(height:200)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal,4),alignment: .leading)
            
            chartTime
                .padding(.horizontal,4)
        }
        .font(.caption)
        .foregroundColor(Color.thems.secondaryColor)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                withAnimation(.linear(duration: 3.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}


extension ChartView{
    private var chartView : some View{
        GeometryReader{ geomtry in
            Path{ path in
                for index in data.indices{
                    let xPosition = geomtry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geomtry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x:xPosition,y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
                
                
            }
            .trim(from: 0,to: percentage)
            .stroke(lineColor , style: StrokeStyle(lineWidth:2,lineCap: .round , lineJoin: .round))
            .shadow(color: lineColor, radius: 10 , x: 0 , y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10 , x: 0 , y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10 , x: 0 , y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10 , x: 0 , y: 40)
            
        }
    }
    private var chartBackground : some View{
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
            
        }
        
    }
    private var chartYAxis : some View{
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            let price = (maxY + minY) / 2
            Text(price.formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    private var chartTime:some View{
        HStack{
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}


