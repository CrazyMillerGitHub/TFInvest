//
//  StockNews.swift
//  News
//
//  Created by Михаил Борисов on 24.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import SwiftUI
import Core

import struct Kingfisher.KFImage

public struct StockNews: View {

    let companyIDX: String

    public init(companyIDX: String) {
        viewModel = StockNewsViewModel(commapyIDX: companyIDX)
        self.companyIDX = companyIDX
    }

    @ObservedObject var viewModel: StockNewsViewModel

    public var body: some View {
        List {
            Section {
                VStack {
                    HStack {
                        Text(viewModel.company.ticker)
                            .font(.caption)
                            .background(Circle()
                                .fill(Color.purple)
                                .frame(width: 40.0, height: 40.0))
                        Text(viewModel.company.name)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                        Text(viewModel.company.currency)
                            .font(.system(size: 14, weight: .light, design: .rounded))
                    }.frame(height: 50)
                    Text(viewModel.company.description)
                        .font(.system(size: 12, weight: .regular, design: .rounded)).padding(.top, 10)
                }
            }
            Section(header: Text("News")) {
                ForEach((0..<viewModel.posts.count), id: \.self) { idx in
                    ZStack {
                        PostsRow(post: self.viewModel.posts[idx])
                        NavigationLink(destination: NewsTopicView(request:
                            URLRequest(url: URL(string: self.viewModel.posts[idx].url)!))) {
                                EmptyView()
                        }.buttonStyle(PlainButtonStyle())
                    }
                }

            }.navigationBarTitle(Text(companyIDX))
                .onAppear {
                    self.viewModel.stockInfo()
                    self.viewModel.fetchPosts()
            }
        }
    }

}

public struct PostsRow: View {

    let post: NewsModel

    public var body: some View {
        HStack {
            VStack {
                Text(post.category)
            }
        }
    }

    func timeStamp(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
}
