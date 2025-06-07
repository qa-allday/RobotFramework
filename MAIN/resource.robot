*** Settings ***
Resource    ../resource.robot

### PAGE OBJECTS
Resource    General/GeneralKeywords.robot
Resource    General/GeneralVariables.robot
Resource    General/Helpers/WebHelpers.robot
Resource    General/Helpers/DataHelpers.robot
Resource    General/TestData/TestData.robot
Resource    Pages/HomePage.robot
Resource    Pages/ProductsPage.robot
Resource    Pages/CartPage.robot
Resource    Pages/SignUpLoginPage.robot
Resource    API/ApiHelpers.robot