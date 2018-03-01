# Tim Burtons Assignment

## Preface

You have recently been hired by a coffee company "Tim Burtons" to develop a
mobile application to serve their customers. The client really wants to leverage
mobile technologies to bring a first class experience for their customers.
The mobile application will eventually provide the following list of features:

1. List of all the products the shop offers
2. Ability to place orders on the mobile phone and pick it up in store
3. Rewards program
4. Messaging system
5. Purchasing gift cards
6. And much more

## Your Task

You have gathered all the requirements and know what you need to build out.
You are still waiting on finalized designs from their UX designers but you have a
few wireframes to get started.
The first deliverable to the client is the following:

1. Setting up the project with an appropriate architecture to ensure the
upcoming features can be built with ease.
2. Create a very basic Overview page which can navigate to a product listing
page.
3. Create a basic product listing page as per the wireframes.

Bonus:
1. Having testing setup
2. Have put thought into configuring the app to run against different
environments (dev, qa, production)

You are free to use any libraries you want to make your life easier. Since you
are just building from wireframes, the UX does not need to be perfect. It just
needs to be functional and should have the ability to easily style once the
designs and assets become available.

API Documentation
URL: https://api.timburtons.com/
GET Products
Route: /v1/products
Response:

{
    "products": [{
                 "id": 1,
                 "name": "Coffee",
                 "size": "small",
                 "cost": 0.99,
                 "type": "drink"
                 },
                 {
                 "id": 2,
                 "name": "Coffee",
                 "size": "medium",
                 "cost": 1.22,
                 "type": "drink"
                 },
                 {
                 "id": 3,
                 "name": "Coffee",
                 "size": "large",
                 "cost": 1.54,
                 "type": "drink"
                 },
                 {
                 "id": 4,
                 "name": "Lemon Poppy Seed Cake",
                 "cost": 0.99,
                 "type": "food"
                 },
                 {
                 "id": 5,
                 "name": "Banana",
                 "cost": 0.99,
                 "type": "food"
                 }
                 ]
}



