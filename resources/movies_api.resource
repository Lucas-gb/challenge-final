*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    DateTime     
Resource   env.resource

*** Keywords ***
Criar Filme na API
    [Documentation]    Cria um novo filme com todos os campos obrigatórios.
    [Arguments]    ${token_admin}    ${titulo_filme}

    @{lista_generos}=      Create List         Ação    Aventura
    ${duracao_int}=        Convert To Integer  140
    ${data_lancamento}=    Get Current Date    result_format=%Y-%m-%d    
    
    ${body}=      Create Dictionary
    ...    title=${titulo_filme}
    ...    genres=${lista_generos}
    ...    releaseDate=${data_lancamento}
    ...    classification=Livre
    ...    duration=${duracao_int}
    ...    director=Lucas Lkz
    ...    synopsis=Um filme incrível sobre a jornada da automação.

    # --- Fazendo a requisição ---
    ${headers}=      Create Dictionary       Authorization=Bearer ${token_admin}
    ${response}=     POST
    ...    url=${BASE_URL}/movies
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=201

    # --- Extraindo o ID da resposta (agora deve funcionar) ---
    ${movie_data}=    Get From Dictionary    ${response.json()}    data
    ${movie_id}=      Get From Dictionary    ${movie_data}         _id

    RETURN    ${movie_id}