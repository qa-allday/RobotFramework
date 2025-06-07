*** Settings ***
Resource    resource.robot

*** Variables ***
${home_menu_icon}=    //*[contains(@class,'navbar')]//*[contains(text(),'Home')]
${products_menu_icon}=    //*[contains(@class,'navbar')]//*[contains(text(),'Products')]
${cart_menu_icon}=    //*[contains(@class,'navbar')]//*[contains(text(),'Cart')]
${signup_login_menu_icon}=    //*[contains(@class,'navbar')]//*[contains(text(),'Signup')]
${testcases_menu_icon}=    //*[contains(@class,'navbar')]//*[contains(text(),'Test Cases')]
${apitesting_menu_icon}=    //*[contains(@class,'navbar')]//*[contains(text(),'API Testing')]
${video_tutorials_menu_icon}=    //*[contains(@class,'navbar')]//*[contains(text(),'Video T')]
${contact_us_menu_icon}=    //*[contains(@class,'navbar')]//*[contains(text(),'Contact Us')]
${logout_menu_icon}=    //*[contains(@class,'navbar')]//*[contains(text(),'Logout')]
${delete_account_menu_icon}=    //*[contains(@class,'navbar')]//*[contains(text(),'Delete Account')]

*** Keywords ***
