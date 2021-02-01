//
//  APIConstants.swift
//  News
//
//  Created by Pavana, Kc (623-Extern) on 29/01/21.
//

import Foundation

let apiKey = "0d1a4df850f848fa81fe4fabe37a77d1"

enum ResponseKey: String {
    case articles = "articles"
    case title = "title"
    case author = "author"
    case description = "description"
    case imageUrl = "urlToImage"
    case articleUrl = "url"
    case likes = "likes"
    case likesCount = "likesCount"
    case comments = "comments"
    case commentsCount = "commentsCount"
}

enum URLConstants: String {
    case newsListUrl = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey="
    case likesUrl = "https://cn-news-info-api.herokuapp.com/likes/"
    case commentUrl = "https://cn-news-info-api.herokuapp.com/comments/"
}
