//
//  LineBox.swift
//  Dashboard
//
//  Created by User on 04.06.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject private var themeManager = SaveManager.shared.theme()
    let data: [TemperatureData]
    let head: String
    //let days: [String]
    //let temperatures: [Double]
    @State private var selectedDataPoint: TemperatureData? = nil
    var body: some View {
        //let data = zip(days, temperatures).map { TemperatureData(label: $0.0, value: $0.1) }
        VStack{
            Text(head)
                .foregroundStyle(themeManager.currentScheme.text)
                .font(.system(size: 25))
                .padding(.top,60)
                .frame(height: 50)
            ScrollView(.horizontal) {
                Chart(data) { entry in
                    
                    
                    LineMark(
                        x: .value("Month", "\(entry.numb)"),
                        y: .value("Amount", entry.value)
                    )
                    PointMark(
                        x: .value("Month", "\(entry.numb)"),
                        y: .value("Amount", entry.value)
                    )
                    .symbol(.circle)
                    .interpolationMethod(.catmullRom)
                    .annotation(position: .top, alignment: .center) {
                        Text("\(entry.value, specifier: "%.1f")")
                            .foregroundColor(themeManager.currentScheme.text)
                            .font(.system(size: 15))
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                    { value in
                        AxisGridLine().foregroundStyle(themeManager.currentScheme.text)
                        AxisTick().foregroundStyle(themeManager.currentScheme.text)
                        AxisValueLabel()
                            .foregroundStyle(themeManager.currentScheme.text)
                            .font(.system(size: 15))// Цвет меток оси X
                    }
                    
                }
                //.chartYScale(domain: 0 ... 30)
                
                .chartXAxis {
                    AxisMarks(values: .automatic) { value in
                        
                        AxisGridLine()
                            .foregroundStyle(themeManager.currentScheme.text)
                        AxisTick()
                            .foregroundStyle(themeManager.currentScheme.text)
                        AxisValueLabel(){
                            Text(data[value.index].label)
                        }
                        .foregroundStyle(themeManager.currentScheme.text)
                        .font(.system(size: 15))// Цвет меток оси X
                    }
                }
                .frame(
                    width: CGFloat(data.count) * 130,
                    height: 200
                )
                
                .padding(50)
            }
            .frame(
                width: 400,
                height: 270
            )
            //.padding(.leading, 100)
            //.padding(.trailing, 100)
            //.padding( 300)
            //HStack(alignment: .bottom, spacing: 16) {
            /*Chart(data) {
             LineMark(
             x: .value("Month", $0.label),
             y: .value("Hours of Sunshine", $0.value)
             )
             .foregroundStyle(themeManager.currentScheme.text)
             
             }
             .frame(
             width: 200
             //height: 300
             )
             .foregroundColor(themeManager.currentScheme.text)
             .chartXAxis {
             AxisMarks(values: .automatic) { _ in
             AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2, 4]))
             .foregroundStyle(Color.indigo)
             AxisTick(stroke: StrokeStyle(lineWidth: 2))
             .foregroundStyle(themeManager.currentScheme.text)
             AxisValueLabel()
             }
             }
             .chartYAxis {
             AxisMarks(values: .automatic) { _ in
             AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
             .foregroundStyle(Color.cyan)
             AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
             .foregroundStyle(themeManager.currentScheme.text)
             AxisValueLabel()
             }
             }
             .chartYAxis {
             AxisMarks(values: .automatic) { value in
             AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
             .foregroundStyle(Color.cyan)
             AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
             .foregroundStyle(Color.red)
             AxisValueLabel() { // construct Text here
             if let intValue = value.as(Int.self) {
             Text("\(intValue) km")
             .font(.system(size: 10)) // style it
             .foregroundColor(.blue)
             }
             }
             }
             }*/
            /*
             ForEach(data) { entry in
             VStack {
             Text("\(Int(entry.value))°C")
             .font(.caption)
             .rotationEffect(.degrees(-45))
             .offset(y: entry.value < 10 ? -20 : 0)
             
             Rectangle()
             .fill(Color.blue)
             .frame(width: 20, height: CGFloat(entry.value) * 10)
             
             Text(entry.day)
             .font(.caption)
             }
             }*/
            // }
            //.padding()
            /*}
             .frame(
             width: 250,
             height: 300
             )
             .background(
             themeManager.currentScheme.primary
             )*/
            //.foregroundColor(themeManager.currentScheme.text)
        }
        .frame(
            width: 360,
            height: 270
        )
        //.padding(.horizontal,200)
        .background(
            RoundedRectangle(
                cornerRadius: 30,
                style: .continuous
            )
            .fill(themeManager.currentScheme.primary)
        )
        //.foregroundColor(themeManager.currentScheme.text)
        .overlay(RoundedRectangle(cornerRadius: 30)
            .stroke(themeManager.currentScheme.secondary, lineWidth: 2))
        //.clipped()
        .clipShape(
            RoundedRectangle(
            cornerRadius: 30,
            style: .continuous
        ))
    }
}

    struct LineBox: View {
        @ObservedObject private var themeManager = SaveManager.shared.theme()
        @State var head: String = "Temp"
        @State var data: [Double] = [23.0, 25.0, 22.0, 26.0, 24.0, 27.0, 23.0,23.0, 25.0, 22.0, 26.0, 24.0, 27.0, 23.0]
        @State var label: [String] = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс","Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
        @State var readyData:[TemperatureData] = []
        
        var body: some View {
            //let days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс","Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
            //let temperatures = [23.0, 25.0, 22.0, 26.0, 24.0, 27.0, 23.0,23.0, 25.0, 22.0, 26.0, 24.0, 27.0, 23.0]
            
            // Объединяем массивы в один массив структур TemperatureData
            //let data = [TemperatureData(days,temperatures)]
            ChartView(data: readyData, head: head)
                .onAppear(){
                    
                    for i in 0...data.count - 1{
                        readyData.append(TemperatureData(label: label[i], value: data[i],numb: i))
                    
                    }
                   /* for (label, data) in zip(label, data) {
                        }*/
                }
        
    }
        
}


/*#Preview {
    LineBox()
}*/
