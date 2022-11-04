//
//  DetailBook.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/04.
//

struct DetailBook: Codable {
    let error: String
    let title: String
    let subtitle: String
    let authors: String
    let publisher: String
    let language: String?
    let isbnShotNumber: String
    let isbnLongNumber: String
    let pages: String
    let year: String
    let rating: String
    let descripiton: String
    let price: String
    let imageURL: String
    let storeURL: String
    let pdfInfo: PDFInfo?
    
    enum CodingKeys: String, CodingKey {
        case error
        case title
        case subtitle
        case authors
        case publisher
        case language
        case isbnShotNumber = "isbn10"
        case isbnLongNumber = "isbn13"
        case pages
        case year
        case rating
        case descripiton = "desc"
        case price
        case imageURL = "image"
        case storeURL = "url"
        case pdfInfo = "pdf"
    }
}

struct PDFInfo: Codable {
    let chapterFirst: String
    let chapterSecond: String

    enum CodingKeys: String, CodingKey {
        case chapterFirst = "Chapter 2"
        case chapterSecond = "Chapter 5"
    }
}
