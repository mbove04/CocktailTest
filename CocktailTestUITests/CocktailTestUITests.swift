


import XCTest

class CocktailTestUITests: XCTestCase {
        
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
       
        XCUIApplication().launch()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
       func testSelectSoda() {
         app.tables.staticTexts["Soft Drink / Soda"].tap()
         XCTAssertEqual(app.tables.staticTexts.count, 21)
     }
    
}





