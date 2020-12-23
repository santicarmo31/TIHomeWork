
## Requirements
 - As a user I want to see a list of all my trips sorted by their distance.
 - As a user I want to be able to change the sort of the trips by their ID alphabetically.
 - As a user I want the mechanism to refresh to see the latest data.
 
### Choose 2 of the following
 - As a user I want my data to persist offline via a local database
 - As a user I want to be able to see a trip displayed on a map to better gauge the distance between the start and end location
 - As a user I want to see how far I currently am from each of the locations associated with a trip.
 
## The Repo
 The project currently has some basic application setup included with it.  The app uses Cocoapods, however the pods should be checked in so there is no command to be run, just make sure to open the `.xcworkspace`.
 
 The `Internal` folder contains some underlying internal implementations that you don't need to touch but facilitates some connections.
 
 The `Bridge` folder has an interface that you need to interact with the underlying methods, or helpers to facilitate some parts of the application. 
 Use the Auth.token(...) func to get an authorization token that should then be set as a http header on requests to the Constants.apiURL endpoint as follows:

 `authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik56WTRRVFZFTmprM01EWTNNems1UVRBMlFqZEJOemRGTXpsRE5rUTNOVVZDTkVVMVFrUXdPUSJ9.eyJuaWNrbmFtZSI6Im1jYWhpbGxhbmUrZHJpdmVyOSIsIm5hbWUiOiJtY2FoaWxsYW5lK2RyaXZlcjlAaW5kaWdvYWcub3JnIiwicGljdHVyZSI6Imh0dHBzOi8vcy5ncmF2YXRhci5jb20vYXZhdGFyLzk4NzhjNDFhYjM1NmE3OTBjMTNlOGMzNjcxNDQ2MmQxP3M9NDgwJnI9cGcmZD1odHRwcyUzQSUyRiUyRmNkbi5hdXRoMC5jb20lMkZhdmF0YXJzJTJGbWMucG5nIiwidXBkYXRlZF9hdCI6IjIwMjAtMDQtMzBUMTU6MDM6MjEuMTUzWiIsImVtYWlsIjoibWNhaGlsbGFuZStkcml2ZXI5QGluZGlnb2FnLm9yZyIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJpc3MiOiJodHRwczovL2luZGlnb2FnLXN0YWdpbmcuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDVlYWFlOGE3OWVjYzMxMGNhNGM2YzdhMSIsImF1ZCI6InphNlRQNU5jUHpVNFJTN2lvU1ZNNE81MWFEbDF5ME95IiwiaWF0IjoxNTg4MjU5MDEyLCJleHAiOjE1ODgzNDU0MTJ9.aNF9Qc8mFcudggtC_JAebtF-qNJ5uRRh9d-guR38wsXAxoPPFsZTeyt18I9D4XFypGDYWp_WNSOcmTTmva7AqcVaQQiu8X4-dWEF_AtunNAU4RcOebrjJTeW2IDcpF-LMOWH-wVU7WLt13NDw9GS1lTSmNa0FT8qBnAT1qPbNZbRKHony4qH9-k7UXpS0eBhQcz-gJ59bzZe53UeoO8KIAepXZ3MrJAp0bJ2KWgXOI0IjlP6g0ywwYVaCBHsQK6ZLu1RZdx3z-zTau3L593KtsmRZd9R5536ZgkLxAH80FTWMK12H5fqoDWBIhx86oRT35YiCnNIqSLAA6xaJP4pBA`
 
 `request_body.json` contains the json that you need to send to the API to get an appropriate response back
 
 ## UI
 The method for implementing the UI is up to you. Do whatever you're most comfortable with.
 
 ## Expectations
 You have up to 5 days to accomplish this assignment.  If you don't get through everything in the 5 days, then it is ok to send in what you have.  If it takes less than a few hours to accomplish, then it is likely a good idea to spend a bit more time showing us you have a good understanding of how to build iOS apps in the project.
 
 ## Write up
 A brief description describing how you went about solving the above problem.  If you were writing this as a PR, what would you write to describe what you did to your team.
