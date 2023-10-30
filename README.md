# Task : Document the steps with screenshots in md files, including proof of the application's accessibility (screenshots taken where necessary)


 - [What is the repository all about ]()


   - Laravel - Laravel is a popular PHP web application framework that is often used in conjunction with the LAMP stack to build web applications.
  
     
   - Lamp stack - The LAMP stack is a software bundle that includes Linux as the operating system, Apache as the web server
  
     
   - The Master and slave - This is used to Setup or Automate he provisioning of two Ubuntu-based servers which is *Master* and *Slave*
  
     
   - Ansible - ansible is a valuable tool for anyone looking to streamline infrastructure management, improve efficiency, and ensure consistency in configuration and deployment processes.


 - [Explaining different sections in the repository]()


   - Ansible-Playbook - Ansible-Playbook: There is a files directory inside ansible playbook, and inside the file directory, there’s another file called Laravel-slave.sh. There’s also the ansible.cfg, the inventory and site-yaml inside the ansible playbook. The ansible.cfg helps to hold the configuration of ansible, while the inventory holds the target machine IP address which is the (salve machine). The site-yaml copies the cron job, copies the file, changes the command of the file and runs or executes Laravel script.


   - laravel-slave.sh -  This file basically installs the whole laravel application and deploys the laravel application with Lamp (Linux, Apache, MYSQL, PHP)


   - Bash.sh -  This  spins up our *Master* and ***Slave*** Machine


   - Laravel-Master.sh - It helps us run or deploy laravel on the ***Master*** *Node*
 

 - [How to run the Repository]()


    - This script is very readable, reuse-able and flexible.
      
  
    - The laravel-master.sh file is to run when the master machine is up


    - To run this script you will need to consider just 3 things


       1. MYSQL Database
       2. .ENV (laravel file)
       3. Ansible.config file


      [MYSQL]()


      - Due to the fact that we are using parameters to create a database while running the script you will need just 2 *arguments*:
  
     
      -  ````bash
         ./laravel-master.sh  David12345 Estherubi
         ````


      - The 1st Arg is for the DB_USERNAME and DB_DATABASE
     

      - The 2nd Arg is for the DB_PASSWORD
     

      - **NOTE** : Whatever username and password you are using it must align with the username and password in the .env file 
     

      [.ENV](github.com/laravel)


      - Since everything is running automatically we will also need to change the .env file
     

      - `````bash
         sudo sed -i -b 's/DB_DATABASE=laravel/DB_DATABASE=David12345/' /var/www/html/laravel/.env
         sudo sed -i -b 's/DB_USERNAME=laravel/DB_USERNAME=David12345/' /var/www/html/laravel/.env
         sudo sed -i -b 's/DB_PASSWORD=/DB_PASSWORD=Estherubi/' /var/www/html/laravel/.env
        ````


      - Make sure this three lines Correspond with the Arg you will be adding while running the script.
     

      [Ansible.config file]()


        - in the ***laravel-master.sh*** file there is a section for the ansible config file
          
       
        - in this path all you will need to chamge is the [*ServerName*]() and the will changing this to the domain name or ip address of the server you want to run the script on.
     
       
        -  if you have all this set then you are ready to run the script like i showed you how.
     

-  [Screenshots]()


    Apache2 Ubuntu Default Page on the Master node ![Apache2 Ubuntu Default Page_ It works and 7 more pages - Personal - Microsoft​ Edge 10_29_2023 6_49_37 PM](https://github.com/DAVE100ice/Altschool-Cloud-Engineering-Exam-Project/assets/131589300/eb7d258b-e56b-48b5-9332-0f375807296d)


    Running Laravel-master.sh on the Master Node as the root user ![root@master_ _vagrant 10_29_2023 8_14_36 AM](https://github.com/DAVE100ice/Altschool-Cloud-Engineering-Exam-Project/assets/131589300/6cfc1bf3-65b7-41dd-9d6a-a721b45efcfb)


     ![root@master_ _vagrant 10_29_2023 8_16_02 AM](https://github.com/DAVE100ice/Altschool-Cloud-Engineering-Exam-Project/assets/131589300/49d052c4-aa09-4069-bcbf-24ae127112f4)


    Laravel on the Master node ![img png ](https://github.com/DAVE100ice/Altschool-Cloud-Engineering-Exam-Project/assets/131589300/a97ac6ce-8534-4b53-9a10-131fbb1817de)






      
 



 
