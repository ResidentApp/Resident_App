# Resident_App

# Branches - 
master - has all the code except the NSFW classifier

front-end(flutter) - has the code front the front-end app

# What is Resident ?
Resident is a Community based Social Awareness App that helps you stay updated with your neighbourhood. From a Pothole hindering the traffic to a new shop opening up in your block, Resident helps you be up-to-date with the affairs of your neighbourhood.

# How to use Resident ?
Using Resident is as simple as using any social app. As soon as you open the app, a feed displaying all the updates in your area is displayed. You can interact with these updates, upvoting and downvoting them depending upon the validity of the update. 
Whenever a new update is posted in your area, you will get a push notification showing you the update and prompting you to interact with it. You can choose to upvote/downvote it if you have info relevant to the update, or you can just not interact with the update if you are unsure about its validity.
Resident like any other platform is susceptible to fake news and updates, hence users should verify any update before reacting on it.


# How does Resident work ?
Resident’s performance, like any other community based app, relies heavily on the quality of the community. We hypothesize that with enough interactions on an update, a pecking order of updates will be formed based on the validity and relevance of the updates. Since the updates are limited by geographical area (1km - 5kms) surrounding the user, the updates are expected to be more relevant to the user, hence prompting a higher interaction rate from the user.
Everything is anonymous in Resident, so you don’t have to worry about your privacy. We understand that with anonymity there comes the associated risk of misuse of the app, we have tried to implement measures to restrict such behaviour to a minimum.
Resident only shows the user updates for the last 24 hours, so you can easily scroll through the updates without feeling like you have been blasted with too much info.
# Features
Anonymity 
Resident offers 100 percent anonymity to its users 
This protects the privacy of the users 
Avoids Biased Feed
Location Based Feed
The user’s feed comprises of update in a limited radius(ranging from 1 to 5km)
This increases the relevance of the feed for the users

Uncluttered UI
As the user is only shown the updates from the past 24 hours & from a limited radius, using the app does not feel tolling.
Since, only the relevant features are addressed, the app feels easy to use 
Neighbourhood Centric
Resident helps you get a better understanding of the issues in and around your neighbourhood.
The prime focus of Resident is to provide a platform to facilitate communication and form a community  
Preventing NSFW Content
We use Perspective API to classify  the content of the flagged updates as appropriate or inappropriate, if the post is found to be inappropriate the post is deleted from the platform.
 Technical Aspects
# Technical Stack
Backend   => Node.js, Express.js, MongoDB Atlas
Frontend => Flutter
Storage => Firebase, MongoDB Atlas
API’s => Perspective APi
Libraries - Mongoose, bcrypt, passport, moment etc.
# Use Cases
Helping users be aware of inconveniences such as waterlogging, potholes, roadblocks etc.
Helping users be aware of their surroundings as they change dynamically
Some real life scenarios - 
COVID-19 Scenarios
Some shops might be closed as the regulations on the opening and closure of businesses changes, this led to frustration in customers who took the risk of going to businesses for availing certain services, only to find out the service or products are unable to be availed.
Users can also remain aware of the scenarios in the hospitals nearby such as availability of ventilators, beds available etc.
Community Rescue
In events of emergency where immediate assistance is required and when the emergency services might not be able to reach in time, this app can let the community know about a situation, and take appropriate steps to remedy the situation. For eg In the plane crash that took place in Kerala (), the community helped provide aid to the victims, while the emergency services on their way. This app can help mobilize more people in the community for good causes and potentially save lives.
How this app helps - This app lets users be aware of the above mentioned scenarios, and take make more informed decisions which would minimize inconveniences and potentially harmful situations.

# Future Prospects
Collaboration with local journalists and verified information providers to facilitate the spread of meaningful and useful information.
Push Notifications. Information that receives more traction within the community and that is by verified and trusted sources will be pushed as notifications to all users within the radius of event.
Separate Commercialized domains for local businesses to publicize their services and products within their community.
 Analysing collected data to generate useful insights which will help existing users, new residents, real estate agents(for property pricings) etc.
