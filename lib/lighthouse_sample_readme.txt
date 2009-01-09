Author: Vidal Graupera

Example lighthouse application readme file

This example shows how to use Rhosync and Rhodes to create an application that works with Lighthouse http://lighthouseapp.com using their REST api http://lighthouseapp.com/api.

Setup Instructions

Pre-requistes

1/ You need a lighthouseapp account
2/ You need to get an API token for your account and enable access to any projects that you want to sync
3/ You need to be able to run your own copy of rhosync
4/ You need to be able to build for at least one handheld platform using rhodes

Rhosync adapters

1/ Start rhosync

2/ Create an application called "Lighthouse"

3/ On the list of "Existing Subscribers" for the application, add your account by clicking "Subscribe user" button

4/ Create 3 sources for the application.

5/ Create the first source and name it "Projects". Set the URL to http://<your subdomain>.lighthouseapp.com, example http://vdggroup.lighthouseapp.com. Set login to your lighthouse API token, and password to "x". For the source adapter class enter "LighthouseProjects"

6/ Create sources for "Users" and "Tickets" with source adapter classes "LighthouseUsers" and "LighthouseTickets" respectively. Use the same URL, login, and password that you entered for Projects.

7/ Go to each of the 3 new sources starting with Projects. From "Editing Source Adapter", click "Show records" and then "Refresh object-value records". You should see records corresponding to your data in Lighthouse. If you see no records, then examine log/development.log for any errors. Double check that you have entered all the values correctly in the fields.

Mobile client instructions

1/ Go to rhodes/apps/Lighthouse directory

2/ You will need to edit the folllowing 3 files

rhodes/apps/Lighthouse/Ticket/config.rb
rhodes/apps/Lighthouse/User/config.rb
rhodes/apps/Lighthouse/Project/config.rb

For example, in Ticket/config.rb change where it says 

Rho::RhoConfig::add_source("Ticket", {"url"=>"http://rhosync.local/apps/2/sources/5", "source_id"=>5})

to the URL of your tickets source adapter from above and the correct source_id. If you are running rhosync on your machine, most likely this will be something like  "http://127.0.0.1:3000/apps/<your app>/sources/<your source id>". Note: such a URL will only work for testing in an emulator on the same machine you are running rhosync on.

change the other two files to the corresponding URLs and source_ids for you system.

3/ Edit Lighthouse/application.rb and set LIGHTHOUSE_ID to your Lighthouse user id.

4/ Build and install rhodes to your device simulator or emulator.

5/ From the device, login.

6/ Then click "Lighthouse" from the list of applications

7/ You should now see your projects, users, and tickets. 
