*** Settings ***
Resource    resource.robot

*** Keywords ***
Verify Product Row
    [Arguments]    ${product}
    Get And Verify Elements Text    //*[contains(text(),'${product}[name]')]//ancestor::tr/*[@class='cart_price']    ${product}[price]
    Get And Verify Elements Text    //*[contains(text(),'${product}[name]')]//ancestor::tr/*[@class='cart_quantity']    ${product}[count]
    ${count}=    Set Variable    ${product}[count]
    ${price}=    Set Variable    ${product}[price]
    ${count}=    Evaluate    int(${count})
    ${price}=    Evaluate    int(${price})
    ${total}=    Evaluate    str(${count}*${price})
    Get And Verify Elements Text    //*[contains(text(),'${product}[name]')]//ancestor::tr/*[@class='cart_total']    ${total}

Verify Product Rows
    [Arguments]    ${products}
    FOR    ${product}    IN    @{products}
        Verify Product Row    ${product}
    END