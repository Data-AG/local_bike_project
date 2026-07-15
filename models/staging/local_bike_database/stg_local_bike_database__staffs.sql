SELECT
    staff_id,
    first_name as staff_first_name,
    last_name as staff_last_name,
    email as staff_email,
    phone as staff_phone,
    active as staff_active,
    store_id,
    SAFE_CAST(manager_id as INT64) as manager_id
FROM
    {{ source('local_bike_database','staffs') }}