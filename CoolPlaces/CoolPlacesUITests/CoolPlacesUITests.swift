//
//  CoolPlacesUITests.swift
//  CoolPlacesUITests
//
//  Created by Elano Vasconcelos on 29/11/24.
//

import XCTest

final class CoolPlacesUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testSelectItemAndLoadDetails() throws {
        let placesListView = app.collectionViews["PlacesListView_List"]
        XCTAssertTrue(placesListView.waitForExistence(timeout: 5))
        
        let listItem = placesListView.buttons["PlaceItemView_32849"]
        listItem.tap()
        
        let addressText = app.staticTexts["PlaceDetail_Address"]
        XCTAssertTrue(addressText.waitForExistence(timeout: 5))
       
        let cityText = app.staticTexts["PlaceDetail_City"]
        XCTAssertTrue(cityText.waitForExistence(timeout: 5))
       
        let countryText = app.staticTexts["PlaceDetail_Country"]
        XCTAssertTrue(countryText.waitForExistence(timeout: 5))
       
        let descriptionText = app.staticTexts["PlaceDetail_Description"]
        XCTAssertTrue(descriptionText.waitForExistence(timeout: 5))
       
        let directionsText = app.staticTexts["PlaceDetail_Directions"]
        XCTAssertTrue(directionsText.waitForExistence(timeout: 5))
    }
}
