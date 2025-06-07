*** Settings ***
Resource    ../resource.robot

*** Keywords ***
Page Should Have URL Matching
    [Arguments]    ${pattern}
    ${url}=    Get Location
    Should Match Regexp    ${url}    ${pattern}

Wait For And Get Element Count
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}
    ${count}=    Get Element Count    ${locator}
    RETURN    ${count}
    
Wait For And Get Element Text
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}
    ${element_text}=    Get Text    ${locator}
    RETURN    ${element_text}

Get And Verify Elements Text
    [Arguments]    ${locator}    ${text}
    ${element_text}=    Wait For And Get Element Text    ${locator}
    Should Contain    ${element_text}    ${text}

Get And Verify Elements Attribute Value
    [Arguments]    ${locator}   ${attribute}    ${value}
    Wait Until Page Contains Element    ${locator}
    ${element_attribute_value}=  Get Element Attribute  ${locator}    attribute=${attribute}
    ${element_attribute_value}=    Convert To String    ${element_attribute_value}
    ${stringValue}=    Convert To String    ${value}
    Should Contain     ${element_attribute_value}      ${stringValue}

Clear Field
    [Arguments]    ${locator}
    ${value}=    Get Value    ${locator}
    ${count}=    Get Length    ${value}
    FOR    ${i}    IN RANGE    ${count}
        Press Keys    ${locator}    BACKSPACE
    END

Input Text Surely
    [Arguments]    ${locator}    ${text}    ${clear}=${EMPTY}
    FOR    ${i}    IN RANGE    9999
        IF    '${clear}' != '${EMPTY}'
            Clear Field    ${locator}
        END
        Wait For And Input Text    ${locator}    ${text}
        ${enteredText}=    Get Text    ${locator}
        ${enteredValue}=    Get Value    ${locator}
        IF    '${enteredText}' != '${EMPTY}'
            IF    '${enteredText}' == '${text}'    BREAK
        ELSE
            IF    '${enteredValue}' == '${text}'    BREAK
        END
    END

Scroll To Bottom Of Page
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight);
