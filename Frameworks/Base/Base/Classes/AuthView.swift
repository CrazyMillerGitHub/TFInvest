//
//  AuthView.swift
//  AuthFramework
//
//  Created by Михаил Борисов on 24.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

public class AuthView: UIView {

    public static var shared = AuthView()

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func test() {
        #if DEBUG
        print("\(#function) just louched")
        #endif
    }

}
