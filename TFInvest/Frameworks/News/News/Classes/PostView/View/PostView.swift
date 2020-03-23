//
//  NewViewController.swift
//  News
//
//  Created by Михаил Борисов on 19.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import SwiftUI

import struct Kingfisher.KFImage

public struct PostsView: View {

    public init() {

    }

    @ObservedObject var viewModel = PostsViewModel()

    public var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.posts) { (post: Post) in
                    ZStack {
                        PostRow(post: post)
                        NavigationLink(destination: NewsTopicView(request:
                            URLRequest(url: post.webURL))) {
                                EmptyView()
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }.navigationBarTitle(Text("News"))
        }

        .onAppear {
            self.viewModel.fetchNewPosts()
        }
    }

}

public struct PostRow: View {

    let post: Post

    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                KFImage(URL(string: post.image))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( height: 150, alignment: .center)
                    .cornerRadius(15)

                Spacer()

                Text(post.headline)
                    .font(.system(.headline, design: .rounded))
                    .lineLimit(2)
                Text(post.summary)
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
