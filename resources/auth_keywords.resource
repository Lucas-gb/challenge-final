*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
# URL oficial do challenge (comentada por enquanto)
# ${BASE_URL}    https://api-cinema-challenge.onrender.com/api/v1

# URL local para desenvolvimento da automação
${BASE_URL}    http://localhost:5000/api/v1

*** Keywords ***
Fazer Login e Obter Token
    [Documentation]    Realiza o login com as credenciais fornecidas e retorna o token de autorização.
    [Arguments]    ${email}    ${password}

    ${body}=    Create Dictionary    email=${email}    password=${password}
    
    Create Session    alias=auth_session    url=${BASE_URL}
    
    ${response}=    POST On Session
    ...    alias=auth_session
    ...    url=/auth/login
    ...    json=${body}
    ...    expected_status=200
    
    
    ${data}=     Get From Dictionary    ${response.json()}    data
    ${token}=    Get From Dictionary    ${data}               token
    
    RETURN    ${token}