## Capstone Concept ##

**Problem Statement:**  
*A clear, concise statement describing the problem 
your project will solve.*  

So you had a bumper crop of tomatoes, or you got a little crazed at the PYO apple place 
and now have gallons of apples waiting to be turned into someting. Enter 
'Pantry App - Name TBD.' You can track all your preserved goods, know when you stored 
them, what is expiring soon, what recipe you used for that particularly delicious batch... 
No more wondering what is in that dusty jar in the back of the cupboard or getting 
stuck in a recipe rut.

**Draft Feature Set:**  
*A detailed outline of all major feature sets 
that will result in the minimum viable product*  
  
- Ability for User to log in/out
- User can log what is in their pantry, including recipe used for creation and food expiration dates.
- User can edit/delete pantry items as needed.
- User can log when pantry items have been used, and that record is stored in the database.
- User can set notifications for when items are getting close to expiration.
- Secure Public API available for other apps to get pantry information (and to connect my front end).

*post-MVP*
- User can easily and quickly search through other users' public pantries and recipes.
- User can upload photos of Pantry Items

(I have a ton of other feature ideas, but I think this might be the MVP?)

**Draft Technology Choices:**  
*This does not need to be final, but you should have an idea of 
which of these technologies you would like to use to accomplish this project* 

- OAuth for login?
- Ruby/Sinatra for server-side RESTful API
- Something lightweight for front end... Ember?
- Background/Async jobs (send e-mails for sign-up verification, trade requests)
- Secure Public API

*Post-MVP*  
*- Elasticsearch to search through User Pantries*  
*- RubyMotion for mobile app for photo upload*