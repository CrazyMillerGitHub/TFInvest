//
//  StockNews.swift
//  News
//
//  Created by Михаил Борисов on 24.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import SwiftUI

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
                                    .frame(width: 40, height: 40))
                            Text(viewModel.company.name)
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                            Text(viewModel.company.currency)
                                .font(.system(size: 14, weight: .light, design: .rounded))
                        }.frame(height: 50)
                        Text(viewModel.company.description.prefix(180))
                            .font(.system(size: 12, weight: .regular, design: .rounded)).padding(.top, 10)
                    }
                }
                Section(header: Text("News")) {
                    Text("HHH")
                    Text("SJJW")
                    Text("FLLLE")
//                    ForEach(viewModel.posts) { (post: Post) in
//                        ZStack {
//                            PostRow(post: post)
//                            NavigationLink(destination: NewsTopicView(request:
//                                URLRequest(url: post.webURL))) {
//                                    EmptyView()
//                            }.buttonStyle(PlainButtonStyle())
//                        }
//                    }
                }
            }.navigationBarTitle(Text(companyIDX))

        .onAppear {
            self.viewModel.stockInfo()
        }
    }

}
