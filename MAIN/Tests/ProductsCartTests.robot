*** Settings ***
Resource    resource.robot
Test Setup    Run Keywords    Begin Web Test
...    AND    Wait For And Click Element    ${products_menu_icon}
Test Teardown    End Web Test

*** Test Cases ***
Search Product
    [Tags]    Critical
    Get And Verify Elements Attribute Value    ${all_products_title}    innerText    ALL PRODUCTS
    Search Product    blue
    Get And Verify Elements Attribute Value    ${searched_products_title}    innerText    SEARCHED PRODUCTS
    Verify Search Products    blue    7

Add Products To Cart
    [Tags]    Critical
    ${product1_dict}=    Create Dictionary    name=Blue Top    count=3    price=500
    ${product2_dict}=    Create Dictionary    name=Blue Slim Fit Jeans    count=1    price=1400
    ${products_list}=    Create List    ${product1_dict}    ${product2_dict}
    Search Product    blue
    Add Products To Cart    ${products_list}
    Wait For And Click Element    ${cart_menu_icon}
    Verify Product Rows    ${products_list}
    
Testsqfq
    [Setup]
    ${string}=    Generate Random String    10
    log to console    \n rand:${string}