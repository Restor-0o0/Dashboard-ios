//
//  ChartDataModel.swift
//  Dashboard
//
//  Created by User on 09.06.2024.
//

import Foundation

struct TemperatureData: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
    let numb: Int
    
}

struct ApiResponse: Codable {
    let login: String
    let numGraphs: Int
    let graph: [[Double]]
    let labels: [[String]]
    let head: [String]
    let numNumbs: Int
    let numbs: [Double]
    let metrics: [String]
    let headNumb: [String]
    
    
    init(login: String = "name", numGraphs: Int = 0, graph: [[Double]] = [[]], labels: [[String]] = [[]], head: [String] = [], numNumbs: Int = 0, numbs: [Double] = [], metrics: [String] = [], headNumb: [String] = []) {
        self.login = login
        self.numGraphs = numGraphs
        self.graph = graph
        self.labels = labels
        self.head = head
        self.numNumbs = numNumbs
        self.numbs = numbs
        self.metrics = metrics
        self.headNumb = headNumb
    }
    
    enum CodingKeys: String, CodingKey {
        case login
        case numGraphs = "num_graphs"
        case graph
        case labels
        case head
        case numNumbs = "num_numbs"
        case numbs
        case metrics
        case headNumb = "head_numb"
    }
}




