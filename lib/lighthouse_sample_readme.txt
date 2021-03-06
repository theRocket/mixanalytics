Author: Vidal Graupera

Example lighthouse application readme file

This example shows how to use Rhosync and Rhodes to create an application that works with Lighthouse http://lighthouseapp.com using their REST api http://lighthouseapp.com/api.

Setup Instructions

Pre-requistes

1/ You need a lighthouseapp account
2/ You need to get an API token for your account and enable access to any projects that you want to sync
3/ You need to be able to run your own copy of rhosync

Rhosync adapters

1/ Start rhosync

2/ Create an application called "Lighthouse"

3/ On the list of "Existing Subscribers" for the application, add your account by clicking "Subscribe user" button

4/ Create 6 sources for the application. The order matters, and you should create them in the following order.

LighthouseProjects
LighthouseTickets
LighthouseUsers
LighthouseSettings
LighthouseMilestones
LighthouseTicketVersions

5/ Create the first source and name it "LighthouseProjects". Set the URL to http://<your subdomain>.lighthouseapp.com, example http://rhomobile.lighthouseapp.com. 

6/ Create sources for "LighthouseTickets", "LighthouseUsers", "LighthouseSettings", "LighthouseMilestones" and "LighthouseTicketVersions" with source adapter classes "LighthouseTickets", "LighthouseUsers", "LighthouseSettings" "LighthouseMilestones" and "LighthouseTicketVersions" respectively. 

7/ Go to Your Subscribed Apps ("/")

These are the apps you are subscribed to.
Name 	Description 	Credentials
Lighthouse 		Create

Click create credentials.

Enter your lighthouse user id under login, example "9810"
Enter "x" for password
Enter your lighthouse API token under token

8/ Go to each of the new sources starting with LighthouseProjects. From "Editing Source Adapter", click "Show records" and then "Refresh object-value records". You should see records corresponding to your data in Lighthouse. If you see no records, then examine log/development.log for any errors. Double check that you have entered all the values correctly in the fields.

Mobile client instructions

1/ Go to rhodes/apps/Lighthouse directory

2/ You will need to update your client to point to your rhosync server. You can do this 2 ways.

a. Update the following files and rebuild the client

rhodes/apps/Lighthouse/Ticket/config.rb
rhodes/apps/Lighthouse/User/config.rb
rhodes/apps/Lighthouse/Project/config.rb
rhodes/apps/Lighthouse/LighthouseSettings/config.rb

For example, in Ticket/config.rb change where it says 

Rho::RhoConfig::add_source("Ticket", {"url"=>"http://rhosync.local/apps/2/sources/5", "source_id"=>5})

to the URL of your tickets source adapter from above and the correct source_id. If you are running rhosync on your machine, most likely this will be something like  "http://127.0.0.1:3000/apps/<your app>/sources/<your source id>". Note: such a URL will only work for testing in an emulator on the same machine you are running rhosync on.

change the other two files to the corresponding URLs and source_ids for you system.

b. From the pre-build executables, go to Edit Sources and change each of the 4 sources, "Projects", "Users", "Tickets" and "LighthouseSettings" and point them to your source URLs for your local Rhosync.

3/ (Build and) install rhodes to your device simulator or emulator.

4/ From the device, login.

5/ Then click "Lighthouse" from the list of applications

6/ You should now see your projects, users, and tickets. 
