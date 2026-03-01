//
//  NewsDTO.swift
//  Dronete
//
//  Created by Daniel Cazorro on 1/3/26.
//

struct NewsDTO: Decodable {
    let id: String
    let title: String
    let description: String
    let imageURL: String?
    let source: String
    let publishedDate: String
}
