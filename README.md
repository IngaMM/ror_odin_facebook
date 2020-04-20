Contactbook

By I. Mahle

A project of The Odin Project: https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project

Instructions

Run rails server and open the browser at http://localhost:3000/

Discussion
I used the following technologies: Ruby on Rails, CSS with Bootstraps for styling

Contactbook (a simplified version of facebook) is built with the following requirements:

1. Users must sign in to see anything except the sign in page.
2. User sign-in should use the Devise gem.
3. Users can send Friend Requests to other Users.
4. A User must accept the Friend Request to become friends.
5. The Friend Request shows up in the notifications section of a User’s navbar.
6. Users can create Posts.
7. Users can Like Posts.
8. Users can Comment on Posts.
9. Posts should always display with the post content, author, comments and likes.
10. Treat the Posts Index page like the real Facebook’s “Timeline” feature – show all the recent posts from the current user and users she is friends with.
11. Users can create a Profile with a Photo.
12. The User Show page contains their Profile information, photo, and posts.
13. The Users Index page lists all users and buttons for sending Friend Requests to those who are not already friends or who don’t already have a pending request.
14. Sign in should use Omniauth to allow a user to sign in with their real Facebook account.
15. Deploy your App to Heroku.

Extras

1. Make posts also allow images.
2. Use the Active Storage to allow users to upload a photo to their profile.
3. Make your post able to be either a text OR a photo by using a polymorphic association (so users can still like or comment on it).
4. Style it up nicely!
   1.-3. are only implemented with local storage and not available in the live version.

Additional comments

The data that are used to seed the database use the gem faker.
Pagination makes it possible to show many posts and photos.

A live version of this app can be found at https://fast-refuge-50407.herokuapp.com

Requirements
Ruby on Rails to run the app locally.
