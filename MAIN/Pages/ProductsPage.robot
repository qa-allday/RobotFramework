*** Settings ***
Resource    resource.robot

*** Variables ***
${product_search_field}=    css:[id='search_product']
${products_search_btn}=    css:[id='submit_search']
${view_cart_link}=    //*[contains(text(),'View Cart')]
${continue_shopping_btn}=    //button[contains(text(),'Continue Shopping')]
${all_products_title}=    //h2[contains(text(),'All Products')]
${searched_products_title}=    //h2[contains(text(),'Searched Products')]

*** Keywords ***
Search Product
    [Arguments]    ${product}
    Input Text Surely    ${product_search_field}    ${product}
    Wait For And Click Element    ${products_search_btn}

Verify Search Products
    [Arguments]    ${name}    ${count}=1
    ${allCardsCount}=    Wait For And Get Element Count    //*[contains(@class,'productinfo')]
    ${labeledCardsCount}=    Wait For And Get Element Count    //*[contains(@class,'productinfo')]//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '${name}')]

Add Product To Cart
    [Arguments]    ${name}    ${position}=1
    Execute JavaScript    window.scrollBy(0, 220)
    Wait For And Mouse Over    (//*[contains(text(),'${name}')]//ancestor::*[contains(@class,'product-image-wrapper')])[${position}]
    Wait For And Mouse Over    (//*[contains(@class,'overlay')]//*[contains(text(),'${name}')]/following-sibling::a)[${position}]
    Wait For And Click Element    (//*[contains(@class,'overlay')]//*[contains(text(),'${name}')]/following-sibling::a)[${position}]
    Wait Until Page Contains    Added!
    Wait Until Page Contains    Your product has been added to cart.
    Wait Until Element Is Visible   ${view_cart_link}
    Wait Until Element Is Visible    ${continue_shopping_btn}

Add Products To Cart
    [Arguments]    ${products}
    FOR    ${product}    IN    @{products}
        ${upper_limit}=    Evaluate    ${product['count']} + 1
        FOR    ${index}    IN RANGE    1    ${upper_limit}
            Add Product To Cart    ${product['name']}
            Wait For And Click Element    ${continue_shopping_btn}
        END
    END
