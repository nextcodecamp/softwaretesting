*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Loan Calculator Page
Suite Teardown    Close Browser

*** Variables ***
${URL}            http://127.0.0.1:8000/carloan/   # Update this with the actual URL of your HTML file
${BROWSER}        Chrome

# Test data for valid and invalid inputs
${VALID_LOAN_AMOUNT}      500000
${VALID_INTEREST_RATE}    2.0
${VALID_LOAN_TERM}        5             

${INVALID_LOAN_AMOUNT_LOW}    99999
${INVALID_LOAN_AMOUNT_HIGH}   1000001

${INVALID_INTEREST_RATE_LOW}      1.2    
${INVALID_INTEREST_RATE_HIGH}     3.7

${INVALID_LOAN_TERM_LOW}      1 
${INVALID_LOAN_TERM_HIGH}     9 

*** Test Cases ***
Test Valid Loan Input
    [Documentation]  Test valid loan values for all fields and check if the monthly payment is calculated correctly.
    Input Loan Amount        loanAmount=${VALID_LOAN_AMOUNT}
    Input Interest Rate      interestRate=${VALID_INTEREST_RATE}
    Select Loan Term         loanTerm=${VALID_LOAN_TERM}
    Submit Form
    Verify Monthly Payment Displayed

Test Invalid Loan Amount Low
    [Documentation]  Test invalid loan amount (below minimum allowed)
    Input Loan Amount          loanAmount=${VALID_INTEREST_RATE}
    Input Interest Rate        interestRate=${VALID_INTEREST_RATE}
    Select Loan Term           loanTerm=${VALID_LOAN_TERM}
    Submit Form
    Verify Loan Amount Error

Test Invalid Interest Rate Low
    [Documentation]  Test invalid interest rate (below minimum allowed)
    Input Loan Amount    ${VALID_LOAN_AMOUNT}
    Input Interest Rate  ${INVALID_INTEREST_RATE_LOW}
    Select Loan Term     ${VALID_LOAN_TERM}
    Submit Form
    Verify Interest Rate Error

Test Invalid Interest Rate Low
    [Documentation]  Test invalid interest rate (above maximum allowed)
    Input Loan Amount    ${VALID_LOAN_AMOUNT}
    Input Interest Rate  ${INVALID_INTEREST_RATE_LOW}
    Select Loan Term     ${VALID_LOAN_TERM}
    Submit Form
    Verify Interest Rate Error

Test Invalid Interest Rate High
    [Documentation]  Test invalid interest rate (above maximum allowed)
    Input Loan Amount    ${VALID_LOAN_AMOUNT}
    Input Interest Rate  ${INVALID_INTEREST_RATE_HIGH}
    Select Loan Term     ${VALID_LOAN_TERM}
    Submit Form
    Verify Interest Rate Error
Test Invalid Loan Term Low
    [Documentation]    This test case verifies the error handling for invalid loan term.
    Input Loan Amount        ${VALID_LOAN_AMOUNT}
    Input Interest Rate        ${VALID_INTEREST_RATE}
    Select Loan Term           ${INVALID_LOAN_TERM_LOW}
    Submit Form
    Verify Loan Term Message   

Test Invalid Loan Term High
    [Documentation]    This test case verifies the error handling for invalid loan term.
    Input Loan Amount        ${VALID_LOAN_AMOUNT}
    Input Interest Rate        ${VALID_INTEREST_RATE}
    Select Loan Term           ${INVALID_LOAN_TERM_HIGH}
    Submit Form
    Verify Loan Term Message  


*** Keywords ***
Open Browser To Loan Calculator Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Input Loan Amount
    [Arguments]    ${loanAmount}
    Input Text    id=loanAmount    ${loanAmount}

Input Interest Rate
    [Arguments]    ${interestRate}
    Input Text    id=interestRate    ${interestRate}

Select Loan Term
    [Arguments]    ${loanTerm}
    Select From List By Value    id=loanTerm    ${loanTerm}

Submit Form
    Click Button    xpath=//button[@type='submit']

Verify Monthly Payment Displayed
    Element Should Contain   id=monthlyPayment       9166.67    

Verify Loan Amount Error
    Element Should Contain    id=loanAmountError    ยอดเงินผ่อนต้องอยู่ระหว่าง 100,000 ถึง 1,000,000 บาท

Verify Interest Rate Error
    Element Should Contain    id=interestRateError          ดอกเบี้ยต้องอยู่ระหว่าง 1.5% ถึง 3.5% ต่อปี
Verify Loan Term Message
    Element Should Contain    id=loanTermError    จำนวนปีที่ผ่อนต้องอยู่ระหว่าง 2 ปี ถึง 8 ปี
