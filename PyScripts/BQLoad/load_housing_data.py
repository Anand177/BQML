""" Run from Terminal
gcloud auth application-default login           
gcloud auth application-default set-quota-project gcp-project-375309
"""
from google.cloud import bigquery
from pathlib import Path

client = bigquery.Client(project="gcp-project-375309")
directory = "BQML/Data/"

housing_table_id = "gcp-project-375309.ml.housing_detail_raw"

housing_schema = [
    bigquery.SchemaField("ID", "INTEGER", "REQUIRED"),
    bigquery.SchemaField("HOUSE_ADDRESS", "STRING", "REQUIRED"),
    bigquery.SchemaField("ZIP", "STRING"),
    bigquery.SchemaField("POPULATION", "INTEGER", "REQUIRED"),  
    bigquery.SchemaField("HOUSE_AGE", "INTEGER", "REQUIRED"),
    bigquery.SchemaField("TOTAL_ROOMS", "INTEGER", "REQUIRED"),
    bigquery.SchemaField("TOTAL_BEDROOMS", "INTEGER", "REQUIRED"),
    bigquery.SchemaField("HOUSE_AREA", "NUMERIC"),
    bigquery.SchemaField("HOUSE_PRICE", "INTEGER", "REQUIRED"),  
    bigquery.SchemaField("OWNER_INCOME", "INTEGER", "REQUIRED"),
]

job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.NEWLINE_DELIMITED_JSON, schema = housing_schema,
    autodetect=False, write_disposition=bigquery.WriteDisposition.WRITE_APPEND, 
)

housing_json_files = Path(f"{directory}").glob("*.json")
print(Path(f"{directory}Header"))
for file_path in housing_json_files:
    print(f"H{file_path}")
    print(f"Reading file -> {file_path} and loading to {housing_table_id}")

    with open(file_path, "rb") as source_file:
        load_job = client.load_table_from_file(source_file, housing_table_id, 
                    job_config=job_config)
    load_job.result()  
    print(f"{file_path} successfully loaded to {housing_table_id}")
    print(f"Loaded {load_job.output_rows} to {housing_table_id} table")