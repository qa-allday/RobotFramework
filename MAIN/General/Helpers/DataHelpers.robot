*** Settings ***
Resource    ../resource.robot

*** Keywords ***
Verify Dictionary Is Not Empty
    [Arguments]    ${dict}
    ${user_keys}=    Get Dictionary Keys    ${dict}
    ${count}=    Get Length    ${user_keys}
    Should Be True    ${count} > 0