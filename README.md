# Allygator Shuttle

## Description 

Allygator shuttle service written in Rails for the full-stack code Challenge. The Application lets you visualize the location and bearing of all vehicles in real-time.

## Requirements
```
- PostgreSQL
- Rails
```
## Installation
Clone the repo then do the following:
```sh
bundle install
rake:db:migrate
```

## Usage
```sh
rails s
```
Then run the simulation using

```sh
yarn start localhost:3000
```

Then visit localhost:3000 to see the live simulation.

## Testing
- Used rspec, factoryBot, and FFaker.
- To run the tests
```sh
rspec
```

## Javascript Libraries used

- [Google maps](https://developers.google.com/maps/) For visualizing vehicles.
- [Marker clustering](https://developers.google.com/maps/documentation/javascript/marker-clustering) For grouping clusters of vehicles together.

## API

### Vehicle Registeration

For vehicle registration 

`POST /vehicles`

| Param | Type | Description | |
| --- | --- | --- | --- |
| id | <code>String</code> | Vehicle ID |required|

```json
{ "id": "Vehicle-id-here" }
```

- Response status code: 204

### Location update

`POST /vehicles/:id/locations`

| Param | Type | Description | |
| --- | --- | --- | --- |
| lat | <code>Decimal</code> | Location latitude |required|
| lng | <code>Decimal</code> | Location longitude |required|
| at | <code>Datetime</code> | Time location retrieved at |required|

```json
{ "lat": 10.0, "lng": 20.0, "at": "2017-09-01T12:00:00Z" }
```

- Response status code: 204

### Vehicle de-registration

`DELETE /vehicles/:id`

| Param | Type | Description | |
| --- | --- | --- | --- |
| id | <code>String</code> | Vehicle ID |required|

- Response status code: 204

### Vehicles locations updates

`GET /get_vehicles_updates`

For getting the latest location for each vehicle.

- Response body

```sh
{
  vehicles: {
  1916:
    {id: 345, 
    lat: "52.45305", 
    lng: "13.4552", 
    retrieved_at: "2017-11-20T01:18:34.816Z", 
    vehicle_id: 1916},
  1917:
    {id: 346, 
    lat: "52.46234", 
    lng: "13.51446", 
    retrieved_at: "2017-11-20T01:18:34.816Z", 
    vehicle_id: 1917}
  }
}
```


## Current Issues
- There was a problem with the delete request in api.js in the driver simulator that I had to change the body in the request from null to {} in order to run properly.

```sh
function deregisterVehicle(vehicleId) {
  request(`/vehicles/${vehicleId}`, "DELETE", {}, res => {
    console.log(`Vehicle de-registered: ${vehicleId}`);
  });
}
```
- The city boundary is too small that most of the vehicles lie outside of it.

## Deployment
- The app is currently deployed on heroku.
- visit https://allygator-shuttle.herokuapp.com/
- Then run the simulator using 
```sh
yarn start allygator-shuttle.herokuapp.com:80
```
## Next Tasks
- Working on making the vehicle movement more smooth.
- Creating docker container.


## Screenshots
![](/screenshots/AllygatorShuttle1.png)
![](/screenshots/AllygatorShuttle2.png)
![](/screenshots/AllygatorShuttle3.png)
![](/screenshots/AllygatorShuttle4.png)
