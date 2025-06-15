# Create list of ACCESS Service principals that could possibly be deleted
* This ticket was formerly taken over by Jae last summer during his STEP-2 internship. The goal of this project is to check DNS, Qualys, and the ACCESS Service Index for any indication that specified service principals may still exist
* The recommended reading Jacob Gallion sent me:
  * [MIT Kerberos Protocol Tutorial](https://www.kerberos.org/software/tutorial.html)
  * [MIT Kerberos Documentation](https://web.mit.edu/kerberos/krb5-latest/doc/user/index.html)
* My readings/documentation I've found for this project:
  * [How to list all SPNs in a domain using PowerShell](https://www.techcrafters.com/portal/en/kb/articles/how-to-list-all-spns-in-a-domain-using-powershell#Security_and_Best_Practices)
  * [How to Check if a Host Principal Exists in Kerberos - NCSA Wiki](https://wiki.ncsa.illinois.edu/display/CSD/HowTo+-+Check+if+a+Host+Principal+Exists+in+Kerberos)
* Jacob is going to send me a list of service principals
* I will check to see if they exist in DNS, Qualys, and the ACCESS Service index, along with the Kerberos logs
* If the service principal does not exist in these four areas, it can be deleted
* Otherwise, mark it as "IN USE" on the service principal list
* Files Jacob added to the ticket:
  * [Principal_List.txt](./Principal_List.txt)
  * [Index.json](./Index.json)
* To find DNS names in Qualys I can use the Asset Search in the VMDR tool. Jacob recommends doing an asset search for all hosts in ALL or ACCESS-CI (Info)
* Right now I need to compare the principal list against Qualys and then the Service Index
* Jacob recommends that I use [nslookup](https://www.nslookup.io/) to check the DNS for each service principal
* Finished checking service principals in Qualys, the ACCESS Service Index, and DNS through nslookup. Submitted a table with each principal and their corresponding yes/no values for each of the three categories onto the Jira ticket. Waiting for response/further instructions from Jacob
* Next step: Once I can access an OmniSOC ELK instance, I'll check if there are any logs for the principals being used