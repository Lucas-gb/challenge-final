*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    env.resource

*** Keywords ***
Criar Filme na API
    [Documentation]    Cria um novo filme usando um token de admin.
    [Arguments]    ${token_admin}    ${titulo_filme}

    ${headers}=      Create Dictionary    Authorization=Bearer ${token_admin}
    
    ${body}=         Create Dictionary
    ...    title=${titulo_filme}
    ...    genres=Ação,Aventura
    ...    director=Lucas Lkz
    ...    duration=120
    ...    synopsis=Um filme incrível sobre automação.

    ${response}=    POST
    ...    url=${BASE_URL}/movies
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=201

    ${movie_data}=    Get From Dictionary    ${response.json()}    data
    ${movie_id}=      Get From Dictionary    ${movie_data}         _id

    RETURN    ${movie_id}