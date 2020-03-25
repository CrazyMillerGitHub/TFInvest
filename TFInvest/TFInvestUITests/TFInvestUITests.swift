//
//  TFInvestUITests.swift
//  TFInvestUITests
//
//  Created by Sergey Korobin on 24.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import XCTest

class TFInvestUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignUpToPinView() {

        // проверяем, что textfield email существует и набираем туда текст
        XCTAssertTrue(app.textFields["email_textfield"].exists)
        
        app.textFields["email_textfield"].tap()
        
        app.textFields["email_textfield"].typeText("sometestmail@ma.ru")

        // проверяем, что textfield password существует и набираем туда текст
        XCTAssertTrue(app.textFields["password_textfield"].exists)
        
        app.textFields["password_textfield"].tap()
        
        // при этом закрываем клавиатуру
        app.textFields["password_textfield"].typeText("12345678\n")
        
        // проверяем, что switch существует и нажимаем на него
        XCTAssertTrue(app.switches["pin_slider"].exists)

        app.switches["pin_slider"].tap()
        
        // проверяем, что button SignIn существует и нажимаем на нее
        XCTAssertTrue(app.buttons["sign_button"].exists)

        app.buttons["sign_button"].tap()

        // проверяем, что кнопка сработала, данные валидны и
        // открылся экран PinView, проверяя label PinLabel на существование
        XCTAssertTrue(app.staticTexts["pin_label"].exists)
    }
    
    func testSignUpToStockView() {
        // проверяем, что textfield email существует и набираем туда текст
        XCTAssertTrue(app.textFields["email_textfield"].exists)
        
        app.textFields["email_textfield"].tap()
        
        app.textFields["email_textfield"].typeText("sometestmail@ma.ru")

        // проверяем, что textfield password существует и набираем туда текст
        XCTAssertTrue(app.textFields["password_textfield"].exists)
        
        app.textFields["password_textfield"].tap()
        
        // при этом закрываем клавиатуру
        app.textFields["password_textfield"].typeText("12345678\n")
        
        // проверяем, что switch существует и нажимаем на него
        XCTAssertTrue(app.switches["pin_slider"].exists)

        app.switches["pin_slider"].tap()

        app.buttons["sign_button"].tap()

        // проверяем, что кнопка сработала, данные валидны и
        // открылся экран PinView, проверяя label PinLabel на существование
        XCTAssertTrue(app.staticTexts["pin_label"].exists)
        
        // ---
        
        // пробегаемся по всем четырем text field'ам и вводим 1
        XCTAssertTrue(app.textFields["pin_textfield_1"].exists)
        
        app.textFields["pin_textfield_1"].tap()
        
        app.textFields["pin_textfield_1"].typeText("1\n")
        
        XCTAssertTrue(app.textFields["pin_textfield_2"].exists)
        
        app.textFields["pin_textfield_2"].typeText("1\n")
        
        XCTAssertTrue(app.textFields["pin_textfield_3"].exists)
        
        app.textFields["pin_textfield_3"].typeText("1\n")
        
        XCTAssertTrue(app.textFields["pin_textfield_4"].exists)
        
        app.textFields["pin_textfield_4"].typeText("1\n")
        
        XCTAssertTrue(app.buttons["confirm_button"].exists)
        
        // подтверждаем создание пин пароля нажатием на button
        app.buttons["confirm_button"].tap()
        
        //---
        
        // удостоверяемся что перешли на экран Stocks проверив существование label
        XCTAssertTrue(app.staticTexts["Available Exchange"].exists)
        
    }
    
    func testPinViewToStockView() {
        
        // пробегаемся по всем четырем text field'ам и вводим 1
        XCTAssertTrue(app.textFields["pin_textfield_1"].exists)
        
        app.textFields["pin_textfield_1"].tap()
        
        app.textFields["pin_textfield_1"].typeText("1\n")
        
        XCTAssertTrue(app.textFields["pin_textfield_2"].exists)
        
        app.textFields["pin_textfield_2"].typeText("1\n")
        
        XCTAssertTrue(app.textFields["pin_textfield_3"].exists)
        
        app.textFields["pin_textfield_3"].typeText("1\n")
        
        XCTAssertTrue(app.textFields["pin_textfield_4"].exists)
        
        app.textFields["pin_textfield_4"].typeText("1\n")
        
        XCTAssertTrue(app.buttons["confirm_button"].exists)
        
        // подтверждаем создание пин пароля нажатием на button
        app.buttons["confirm_button"].tap()
        
        //---
        
        // удостоверяемся что перешли на экран Stocks проверив существование label
        XCTAssertTrue(app.staticTexts["Available Exchange"].exists)
    }

}
