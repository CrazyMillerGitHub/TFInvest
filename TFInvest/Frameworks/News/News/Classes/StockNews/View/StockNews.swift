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
        viewModel = StockNewsViewModel(companyIDX: companyIDX)

        self.companyIDX = companyIDX
    }

    @ObservedObject var viewModel: StockNewsViewModel

    public var body: some View {
            VStack {
                HStack(alignment: .center, spacing: 10) {
                    Text(viewModel.company.ticker ?? "ticker")
                        .font(.caption)
                        .background(Circle()
                            .fill(Color.purple)
                            .frame(width: 40.0, height: 40.0))
                    Text(viewModel.company.name ?? "name")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                    Text(viewModel.company.currency ?? "currency")
                        .font(.system(size: 14, weight: .light, design: .rounded))
                }.frame(height: 50)
                Text(viewModel.company.newsDescription?.prefix(180) ?? "description")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))

                List {
                    Section(header: Text("News")) {
                        ForEach(viewModel.posts) { (post: NewsModel) in
                            ZStack {
                                PostsRow(post: post)
                                NavigationLink(destination: NewsTopicView(request:
                                    URLRequest(url: URL(string: post.url)!))) {
                                        EmptyView()
                                }.buttonStyle(PlainButtonStyle())
                            }
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
            VStack(alignment: .leading, spacing: 20) {
                KFImage(URL(string: post.image))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( height: 150, alignment: .center)
                    .cornerRadius(15)
                Text(post.headline)
                    .font(.system(.headline, design: .rounded))
                    .lineLimit(2)
                Text(post.summary ?? "")
                    .font(.system(.footnote, design: .rounded))
                    .lineLimit(5)
                HStack {
                    Text(timeStamp(timestamp: post.datetime))
                        .font(.system(.caption, design: .rounded))
                    Text("Read more")
                        .font(.system(.subheadline, design: .rounded))
                }.lineSpacing(30)

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
