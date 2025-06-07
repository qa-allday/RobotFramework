*** Settings ***
Resource    resource.robot
Test Setup    Run Keywords    Begin Web Test
...    AND    Wait For And Click Element    ${signup_login_menu_icon}
Test Teardown    End Web Test

*** Test Cases ***
Login with Valid Credentials and Logout
    [Tags]    Critical
    Login To Application    ${login_tester}    ${password}
    Wait Until Page Contains Element    ${delete_account_menu_icon}
    Wait For And Click Element    ${logout_menu_icon}
    Page Should Have URL Matching    .*login
    Wait Until Page Contains Element    ${signup_login_menu_icon}
    Wait Until Page Contains Element    ${login_email_input}

Register New User
    [Tags]    Critical
    ${user}=    Generate New User Data
    Wait Until Element Is Visible    ${signup_name_input}
    Start Registration    ${user}
    Element Value Should Be Equal    ${signup2_name_input}    ${user}[name]
    Element Value Should Be Equal    ${signup2_email_input}    ${user}[email]
    Fill In Registration Form    ${user}
    Wait For And Click Element    ${signup2_create_account_btn}
    Get And Verify Elements Attribute Value    ${account_created_title}    innerText    ACCOUNT CREATED
    Wait Until Element Is Visible    ${signup2_continue_btn}
    Wait For And Click Element    ${signup2_continue_btn}
    Wait Until Element Is Visible    ${logout_menu_icon}
    Wait Until Element Is Visible    ${delete_account_menu_icon}
    Wait Until Element Is Not Visible    ${signup_login_menu_icon}
    Wait For And Click Element    ${delete_account_menu_icon}
    Get And Verify Elements Attribute Value    ${account_deleted_title}    innerText    ACCOUNT DELETED
    Wait Until Element Is Visible    ${signup2_continue_btn}
    Wait For And Click Element    ${signup2_continue_btn}
    Wait Until Element Is Visible    ${signup_login_menu_icon}