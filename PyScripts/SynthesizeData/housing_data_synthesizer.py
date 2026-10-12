from datetime import datetime
from faker import Faker

import pandas as pd
import random, time

fake = Faker()

num_rows = 1000

def generate_number(number: list[int], weight: list[int]) -> int:
    return random.choices(number, weight, k=1)[0]

def generate_home_bedrooms() -> int:
    return generate_number([1, 2, 3, 4, 5, 6], [5, 40, 45, 5, 3, 2])

def generate_home_rooms(bedroom: int) -> int:
    return bedroom + generate_number([2, 3, 4] , [60, 35, 5])

def synthesize_data(scope :int ) :

    id_list : list[int] = []
    address_list : list[str] = []
    zip_list : list[str] = []
    zip_population_list: list[int] = []
    house_age_list: list[int] = []
    home_rooms_list: list[int] = []
    home_bedrooms_list: list[int] = []
    home_area_list: list[float] = []
    home_price_list: list[int] = []
    house_owner_income_list: list[int] = []

    for i in range(1000):

        id_list.append(i + scope)

        address_list.append(fake.street_address() + ", " + fake.city())
        zip_list.append(f"{10000+i}")
        zip_population_list.append(random.randint(20000, 100000))
        house_age_list.append(random.randint(1, 30))

        home_bedrooms : int = generate_home_bedrooms()
        home_rooms : int = generate_home_rooms(home_bedrooms)
        home_bedrooms_list.append(home_bedrooms)
        home_rooms_list.append(home_rooms)

        area = round((random.uniform(home_rooms * 150, home_rooms * 250) + random.uniform(200, 500)), 
                     2) 
        home_area_list.append(area)
        home_price_list.append(int(area * 400 * (40-house_age_list[i])/30))
        house_owner_income_list.append(random.randint(6000 , 20000)*10)

    housing_data = {
        "id" : id_list,
        "house_address" : address_list,
        "zip" : zip_list,
        "population" : zip_population_list,
        "house_age" : house_age_list,
        "total_rooms" : home_rooms_list,
        "total_bedrooms" : home_bedrooms_list,
        "house_area" : home_area_list,
        "house_price" : home_price_list,
        "owner_income" : house_owner_income_list
    }

    housing_df = pd.DataFrame(housing_data)
    housing_df = housing_df.astype({"house_address" : "string", "zip": "string"})

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    housing_df.to_json(f"BQML/Data/housing_{timestamp}.json", orient="records", index=False,
                    lines=True)

if __name__ == "__main__":
    for i in range(10):
        synthesize_data(i*1000+10000)
        time.sleep(1)

