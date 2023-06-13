# Makers Academy - Takeawy Challenge

This repository contains a solution for Makers Academy Takeaway Challange - the final project of the Golden Square module. The four sides of the Golden Square are TDD, OOD, debugging and pair programming. This challenge in particular puts the first three of those into practice since it was completed solo. The [brief](https://github.com/makersacademy/golden-square/blob/main/projects/README.md) consisted of user stories that were used as the starting point for the [recipe.md file](recipe.md). This includes an initial diagram I created to begin to conceptualise the design of the classes in the program. This design was modified and iterated upon during development.

## Getting started

Clone the repo:

 `git clone https://github.com/tomcarmichael/makers-takeaway-challenge.git`

Install dependancies:

`bundle install` 

Sign up for a free trial or login to your existing [Twilio](www.twilio.com) account.

After login, copy your 'Account SID' from the twilio console page.

In your terminal, run `export TWILIO_ACCOUNT_SID=[your_copied_account_SID]` (excluding the square brackets)

Next copy your 'Auth Token' from the twilio console page.

In your terminal, run `export TWILIO_AUTH_TOKEN=[your_copied_auth_token]` (excluding the square brackets)

Now copy 'My Twilio phone number' from the twilio console page.

In your terminal, run `export TWILIO_SENDER_NUMBER=[your_copied_twilio_phone_number]` (excluding the square brackets)

Now to set the phone number that you want the SMS confirmation of the order sent to (your own mobile phone number)

In your terminal, run `export RECEIVER_PHONE_NUMBER=[your_phone_number]` (prepended with your country calling code, and excluding the square brackets)

E.g. +447770000000 for a UK number




Run tests to ensure the project is set up correctly:

`rspec`

## Usage

This program is run at the command line using the ruby interpreter.

`ruby lib/main.rb` 

Respond to the prompts at the command line to place your order, and you should be presented with a receipt at the end of the program, and receive an SMS confirmation of your 'order'.

## Design and Implementation

This was my first attempt at designing a multi-class program from scratch alone. There is still much to learn!

`main.rb` instantiates several instances of the `Dish` class, each of which is added to an instance of the `Menu` class via its provided `.add` method.

The `Order` class assigns a unique ID to the order upon construction, and increments a Class variable that keeps track of the total number of orders created thus far. It stores the dishes a user has ordered in the `@basket` attribute (an array of `Dish` objects) and provides methods to order from a particular `Menu`, add/remove items from the order and retrieve the user's name assigned to the order upon construction, as well the contents of `@basket`.

The `Confirmation` class handles functionality to notify the user of their confirmed order and delivery time, as well as returning a formatted receipt, which it accomplishes by instantiating the `Receipt` class from within its `.receipt` method. `Receipt`'s sole purpose is to take the contents of the `@basket` and use this to create a formatted receipt, which is returned as an array of strings. 

Dependancy injection was used throughout so that unit tests could be written for each class, in addition to the `spec/integration_spec.rb` file. 

