// *****PLEASE ENTER YOUR DETAILS BELOW*****
// T3-tsa-mongo.mongodb.js

// Student ID:          3182616
// Student Name:        Garret Yong Shern Min
// Unit Code:           FIT3171
// Applied Class No:    06

//Comments for your marker:


//Use (connect to) your database - you MUST update xyz001
//with your authcate username
use("gyon0004");

//3(b)
// PLEASE PLACE REQUIRED MONGODB COMMAND TO CREATE THE COLLECTION HERE
// YOU MAY PICK ANY COLLECTION NAME
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
db.resortInfo.insertMany([
    {"_id":1,"name":"Byron Bay, NSW","location":{"latitude":-28.6474,"longitude":153.602},"avg_temperature":{"summer":23.5,"winter":16.9},"no_of_resorts":2,"resorts":[{"id":1,"name":"Byron Bay Exclusive Resort","address":"1 Karma Road","phone":"0212429423","year_built":"2012","company_name":"Byron Holiday"},{"id":5,"name":"Byron Bay Super Resort","address":"675 Lennon Street","phone":"0224811234","year_built":"2016","company_name":"Byron Holiday"}]},
    {"_id":2,"name":"Mudgee, NSW","location":{"latitude":-32.6145,"longitude":149.5733},"avg_temperature":{"summer":23,"winter":8.3},"no_of_resorts":1,"resorts":[{"id":10,"name":"Awesome Resort","address":"40 Moonlight Road","phone":"0228503123","year_built":"2018","company_name":"Wonderful Dessert Accommodation"}]},
    {"_id":3,"name":"Kingaroy, QLD","location":{"latitude":-26.5309,"longitude":151.84},"avg_temperature":{"summer":24.8,"winter":11.5},"no_of_resorts":1,"resorts":[{"id":8,"name":"King Resort at Kingaroy","address":"23A Town Road","phone":"0746101231","year_built":"2018","company_name":"Tropical Dream"}]},
    {"_id":4,"name":"Gympie, QLD","location":{"latitude":-26.1834,"longitude":152.6657},"avg_temperature":{"summer":27.1,"winter":13.6},"no_of_resorts":1,"resorts":[{"id":6,"name":"Gympie Luxury Resort","address":"1234 Gympie Hwy","phone":"0745703124","year_built":"2014","company_name":"Tropical Dream"}]},
    {"_id":5,"name":"Alice Springs, NT ","location":{"latitude":-23.698,"longitude":133.8807},"avg_temperature":{"summer":29,"winter":13},"no_of_resorts":1,"resorts":[{"id":3,"name":"Alice Springs Resort","address":"1 Wonderland Road","phone":"0870003111","year_built":"2011","company_name":"Wonderful Dessert Accommodation"}]},
    {"_id":6,"name":"Broome, WA ","location":{"latitude":-17.9644,"longitude":122.2304},"avg_temperature":{"summer":32,"winter":21},"no_of_resorts":1,"resorts":[{"id":4,"name":"Awesome Resort","address":"1 Crystal Clear Road","phone":"0853246725","year_built":"2008","company_name":"Wonderful Dessert Accommodation"}]},
    {"_id":7,"name":"Mount Isa, QLD","location":{"latitude":-20.7256,"longitude":139.4927},"avg_temperature":{"summer":31.9,"winter":17.3},"no_of_resorts":1,"resorts":[{"id":9,"name":"Queen Resort","address":"45 Mount Isa Road","phone":"0748253123","year_built":"2017","company_name":"Tropical Dream"}]},
    {"_id":8,"name":"Taree, NSW","location":{"latitude":-31.8895,"longitude":152.4444},"avg_temperature":{"summer":24.3,"winter":12},"no_of_resorts":1,"resorts":[{"id":7,"name":"Taree Exclusive Resort","address":"78 Station Road","phone":"0243012123","year_built":"2014","company_name":"Australia Experience"}]},
    {"_id":9,"name":"Echuca, VIC","location":{"latitude":-36.146,"longitude":144.7448},"avg_temperature":{"summer":22.2,"winter":9.3},"no_of_resorts":1,"resorts":[{"id":2,"name":"Amazing Resort","address":"5B Lincoln Way","phone":"0326415234","year_built":"2014","company_name":"Australia Experience"}]}
]);

//3(c)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
db.resortInfo.find({"avg_temperature.summer":{"$gt":25}, "resorts.company_name":"Tropical Dream" });

///3(d)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer


db.resortInfo.find({"resorts.company_name":"Tropical Dream"});

db.resortInfo.updateMany({"resorts.company_name":"Tropical Dream"},{"$set":{"resorts.$.company_name":"Tropical Heaven"}})

db.resortInfo.find({"resorts.company_name":"Tropical Dream"});

db.resortInfo.find({"resorts.company_name":"Tropical Heaven"});

//3(e)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

db.resortInfo.find({"name": "Mount Isa, QLD", "location.latitude": -20.7256, "location.longitude": 139.4927});

db.resortInfo.updateOne({"name": "Mount Isa, QLD", "location.latitude": -20.7256, "location.longitude": 139.4927}, {"$push":{"resorts":{"id": 10, "name":"Amazing Resort","address":"40 Moonlight Road","phone":"0228503123","year_built":"2018","company_name":"Australia Experience"}}});

db.resortInfo.find({"name": "Mount Isa, QLD", "location.latitude": -20.7256, "location.longitude": 139.4927});