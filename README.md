# Collaborators
- Mel Langhoff - [GitHub](github.com/mel-langhoff)
- Jared Hobson - [GitHub](github.com/JaredMHobson)

# About This Project
This builds an API that lets you access a database of Farmers Markets and their Vendors. You can search for Markets with their city, state or name. You can also find nearby ATMs to those Markets. 

# Setup
1. Download or clone this repo
2. Open in your favorite code editor
3. Add the below to your db/seeds.rb file
```
cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d market_money_development db/data/market_money_development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)
```
4. Run `$ rails db:{drop,create,migrate,seed}` and you may see lots of output including some warnings/errors from `pg_restore` that you can ignore.
5. Run `$ rails db:schema:dump`
6. Sign up for a TomTom API key here: https://developer.tomtom.com/user/register?destination=/how-to-get-tomtom-api-key
7. Run `$ EDITOR="code --wait" rails credentials:edit`
- You may need to delete your `config/credentials.yml` and `config/master.key` files if the temporary `credentials.yml` file does not open
8. In your temporary `credentials.yml` file, enter your TomTom API key like so and then close the `credentials.yml` file
```
tomtom: 
  key: <your_api_key>
```
9. Start a Rails server with `$ rails s`, and you can now access the various endpoints offered

# Endpoints
## Get All Markets
Gets a list of all markets and their attributes along with the IDs of all of their vendors. 
`GET http://localhost:3000/api/v0/markets`

## Get Market by ID
Gets a single market's information by using their ID.
`GET http://localhost:3000/api/v0/markets/{{market_id}}`

## Get All Vendors for a Market
Gets a list of all vendors and their attributes that belong to the market whose ID you pass.
`GET http://localhost:3000/api/v0/markets/{{market_id}}/vendors`

## Get Vendor by ID
Gets a single vendor's information by using their ID. 
`GET http://localhost:3000/api/v0/vendors/{{vendor_id}}`

## Create a Vendor
Creates a new vendor record when passing all attributes for a vendor through `params[:vendor]`

### Example Params
```JSON
  { 
    "vendor": 
    {
      "name": "Random Name",
      "description": "Random Description",
      "contact_name": "Random Contact Name",
      "contact_number": "(123) 456 7890",
      "credit_accepted": true,
    }
  }
```
`POST http://localhost:3000/api/v0/vendors`

## Delete a Vendor
Deletes a vendor when passing a valid vendor ID
`DELETE http://localhost:3000/api/v0/vendors/{{vendor_id}}`

## Update a Vendor
Updates a vendor's information when passing any vendor attribute through params along with a valid vendor ID.
`PATCH http://localhost:3000/api/v0/vendors/{{vendor_id}}`

## Create a MarketVendor
Creates a market vendor pair, linking a market with a vendor. Duplicate entries cannot be created, and a valid market ID AND vendor ID must be passed through `params[:market_id]` and `params[:vendor_id]` respectively.

### Example Params
```JSON
  {
    "market_id": 234234,
    "vendor_id": 22114
  }
```
`CREATE http://localhost:3000/api/v0/market_vendors`

## Delete a MarketVendor
Deletes a market vendor pair. A valid market ID AND vendor ID must be passed through `params[:market_id]` and `params[:vendor_id]` respectively.
`DELETE http://localhost:3000/api/v0/market_vendors`

## Search Markets by state, city, and/or name
Searches for a market by sending a state, city and/or name through query params. </br>
The following combination of parameters can be sent in at any time:
- state
- state, city
- state, city, name
- state, name
- name</br>

The following combination of parameters can NOT be sent in at any time:
- city
- city, name
`GET /api/v0/markets/search?city=albuquerque&state=new Mexico&name=Nob hill`

## Get ATMs Near a Market
Finds all nearby ATMs, and their attributes, to a market's location using its latitude and longitude by passing a valid market ID.
`GET http://localhost:3000/api/v0/markets/{{market_id}}/nearest_atms`