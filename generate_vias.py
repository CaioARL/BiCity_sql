import json

count_trechos = 0
count_infra = 0

# Ler o arquivo GeoJSON
with open(
    "ciclomapa-São Paulo, São Paulo, Brasil_filtrado.geojson", "r", encoding="utf-8"
) as file:
    data = json.load(file)

# Coletar tipos únicos
tipos = {
    "Ciclovia": {
        "1": "Via exclusiva e segregada para uso de bicicletas, separada do tráfego de veículos e pedestres."
    },
    "Ciclofaixa": {
        "2": "Faixa destinada às bicicletas, demarcada por sinalização no leito das vias urbanas, sem separação física."
    },
    "Ciclorrota": {
        "3": "Trajeto sinalizado em vias compartilhadas para ciclistas, sem exclusividade ou segregação."
    },
    "Calçada compartilhada": {
        "4": "Área destinada ao uso conjunto de pedestres, ciclistas e veículos, com prioridade geralmente definida por normas locais."
    },
}
with open("insercoes.sql", "w", encoding="utf-8") as sql_file:
    sql_file.write("BEGIN;\n")

    tipo_id_map = {tipo: idx + 1 for idx, tipo in enumerate(tipos)}

    # Inserir infraestrutura_cicloviaria em lote
    infraestrutura_values = []
    trecho_values = []
    tipo_infraestrutura_cicloviaria_values = []

    id = 1
    for feature in data["features"]:

        json_id = feature["id"]

        # Propriedades
        if "name" not in feature["properties"]:
            nome_properties = ""
        else:
            nome_properties = feature["properties"]["name"].replace("'", " ")

        tipo_properties_id = tipo_id_map[feature["properties"]["type"]]

        # Geometria
        geometria = feature["geometry"]["type"]

        infraestrutura_values.append(
            f"('{json_id}','{nome_properties}', 0, '{geometria}', {tipo_properties_id})"
        )
        count_infra += 1

        geometry = feature["geometry"]
        coordinates = geometry["coordinates"]
        if geometria == "Polygon":
            coordinates = geometry["coordinates"][0]

        for coordinate in coordinates:
            longitude, latitude = coordinate
            trecho_values.append(f"('{latitude}', '{longitude}', {id})")
            count_trechos += 1
        id += 1

    for nome, detalhes in tipos.items():
        for id, descricao in detalhes.items():
            sql_file.write(
                f"INSERT INTO tipo_infraestrutura_cicloviaria (id, nome, descricao) VALUES ({id}, '{nome}', '{descricao}');\n"
            )

    infraestrutura_values_str = ",\n".join(infraestrutura_values)
    sql_file.write(
        f"INSERT INTO infraestrutura_cicloviaria (json_id, nome_localidade, nota_media, geometria, id_tipo_infraestrutura_cicloviaria) VALUES\n{infraestrutura_values_str};\n"
    )

    trecho_values_str = ",\n".join(trecho_values)
    sql_file.write(
        f"INSERT INTO trecho (latitude, longitude, id_infraestrutura_cicloviaria) VALUES\n{trecho_values_str};\n"
    )    

    sql_file.write("COMMIT;\n")
    
    # Relatório
    print(f"Total de tipos de infraestrutura: {len(tipos)}")
    print(f"Total de infraestruturas: {count_infra}")
    print(f"Total de trechos: {count_trechos}")
