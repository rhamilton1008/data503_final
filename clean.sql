CREATE TABLE newjson2 AS
SELECT raw_json['data']['home_search']['results']['0'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['1'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['2'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['3'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['4'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['5'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['6'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['7'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['8'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['9'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['10'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['11'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['12'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['13'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['14'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['15'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['16'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['17'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['18'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['19'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['20'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['21'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['22'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['23'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['24'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['25'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['26'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['27'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['28'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['29'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['30'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['31'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['32'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['33'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['34'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['35'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['36'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['37'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['38'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['39'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['40'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['41'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['42'] AS house FROM raw_data_sold
UNION ALL
SELECT raw_json['data']['home_search']['results']['43'] AS house FROM raw_data_sold
;

insert into sold_homes
SELECT
    (house['description']['beds']::int) AS beds,
    (house['description']['baths']::int) AS baths,
    CASE 
      WHEN house['description']['stories'] = 'null' THEN null
      ELSE (house['description']['stories']::text)::int
    END AS stories,
    CASE 
      WHEN house['description']['garage'] = 'null' THEN 0
      ELSE (house['description']['garage']::text)::int
    END AS garage,
    (house['description']['type']::text) AS type,
    (house['description']['year_built']::int) AS year_built,
    CASE 
      WHEN house['description']['sqft'] = 'null' THEN null
      ELSE (house['description']['sqft']::text)::int
    END AS sqft,
    CASE 
      WHEN house['description']['lot_sqft'] = 'null' THEN null
      ELSE (house['description']['lot_sqft']::text)::int
    END AS lot_sqft,
    CASE
      WHEN house['list_date'] = 'null' THEN null
      ELSE (house['list_date']::TEXT)::DATE
     END AS list_date,
    (house['description']['sold_date']::text)::date AS sold_date,
    (house['status']::text) AS sale_status,
    CASE
      WHEN house['list_price'] = 'null' THEN null
      ELSE (house['list_price']::TEXT)::int
     END AS list_price,
    (house['description']['sold_price']::int) as sold_price,
    (house['property_id']::text) AS property_id,
    (house['location']['address']['coordinate']['lon']::float) AS longitude,
    (house['location']['address']['coordinate']['lat']::float) AS latitude,
    (house['location']['address']['state_code']::text) AS state,
    (house['location']['address']['city']::text) AS city,
    (house['location']['address']['line']::text) AS address,
    (house['location']['address']['postal_code']::text) AS zip
 FROM newjson2
 ON CONFLICT (address)
 DO NOTHING;

 INSERT INTO raw_data_sold_test
 SELECT * FROM raw_data_sold;
 
 DROP TABLE newjson2;

 DELETE FROM raw_data_sold;
