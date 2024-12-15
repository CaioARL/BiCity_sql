import json

count_trechos = 0
count_infra = 0

# Ler o arquivo GeoJSON
with open(
    "ciclomapa-São Paulo, São Paulo, Brasil_filtrado.geojson", "r", encoding="utf-8"
) as file:
    data = json.load(file)

# Coletar tipos únicos
tipos = set()
for feature in data["features"]:
    tipos.add(feature["properties"]["type"])

with open("insercoes.sql", "w", encoding="utf-8") as sql_file:
    sql_file.write("BEGIN;\n")
    
    tipo_id_map = {tipo: idx + 1 for idx, tipo in enumerate(tipos)}

    # Inserir infraestrutura_cicloviaria em lote
    infraestrutura_values = []
    trecho_values = []
    id = 1
    for feature in data["features"]:
        tipo = feature["properties"]["type"]
        id_feature = str(feature["properties"]["id"])
        geometria = feature["geometry"]["type"]
        tipo_id = tipo_id_map[tipo]

        infraestrutura_values.append(f"('{id_feature}', 0, '{geometria}', {tipo_id})")
        count_infra += 1

        geometry = feature["geometry"]
        coordinates = geometry["coordinates"]
        if geometria == "Polygon":
            coordinates = geometry["coordinates"][0]

        for coordinate in coordinates:
            longitude, latitude = coordinate
            trecho_values.append(f"('{id_feature}', '{latitude}', '{longitude}', {id})")
            count_trechos += 1
        id += 1

    infraestrutura_values_str = ",\n".join(infraestrutura_values)
    sql_file.write(
        f"INSERT INTO infraestrutura_cicloviaria (nome, nota_media, geometria, id_tipo_infraestrutura_cicloviaria) VALUES\n{infraestrutura_values_str};\n"
    )

    trecho_values_str = ",\n".join(trecho_values)
    sql_file.write(
        f"INSERT INTO trecho (nome, latitude, longitude, id_infraestrutura_cicloviaria) VALUES\n{trecho_values_str};\n"
    )

    sql_file.write("COMMIT;\n")
    print(
        f"Trechos: {count_trechos}\nInfraestruturas: {count_infra}"
    )
