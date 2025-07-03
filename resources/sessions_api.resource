*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    DateTime
Resource   env.resource

*** Keywords ***
Criar Sessão na API
    [Documentation]    Cria uma nova sessão para um filme e sala específicos, usando a sessão de admin.
    [Arguments]    ${token_admin}    ${movie_id}    ${theater_id}

    ${headers}=      Create Dictionary
    ...    Authorization=Bearer ${token_admin}
    ...    Content-Type=application/json

    # Gera uma data e hora para amanhã às 20:30
    ${data_hoje}=      Get Current Date
    ${data_futura}=    Add Time To Date    ${data_hoje}    1 day    result_format=%Y-%m-%dT20:30:00.000Z

    ${preco_int}=      Convert To Integer    30
    ${meia_int}=       Convert To Integer    15

    ${body}=         Create Dictionary
    ...    movie=${movie_id}
    ...    theater=${theater_id}
    ...    datetime=${data_futura}
    ...    fullPrice=${preco_int}
    ...    halfPrice=${meia_int}

    # Usa a mesma sessão do login
    ${response}=    POST On Session
    ...    alias=auth_session
    ...    url=/sessions
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=201

    ${session_data}=    Get From Dictionary    ${response.json()}    data
    ${session_id}=      Get From Dictionary    ${session_data}      _id

    RETURN    ${session_id}