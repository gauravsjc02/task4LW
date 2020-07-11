# task4LW
<h1>Create a WebServer Setup on Kubernetes using the Dynamic Slave Node of Jenkins.</h1>

<h3>Steps :</h3>
<ol>
<li>
1. Create a Dockerfile having SSH and Kubectl configured
  </li>
  <li>
2. Configure the Docker server so that Jenkins Docker Plugin can communicate
  </li>
  <li>
3. Use the created Dockerfile as the Dynamic Node Template, which can be used by specifying certain labels
  </li>
  <li>
4. Create another Dockerfile which acts as a webserver image for the Kubernetes Pods
  </li>
  <li>
5. Create Deployment/ RollOut Update to the Kubernetes using the Dynamic Slave.
  </li>
A) If launching first time then create a deployment of the pod using the image created in the previous job. Else if deployment already exists then do roll-out of the existing pod making zero downtime for the user.

B) If Application created first time, then Expose the application. Else don’t expose it.
</ol>

<h3>Solution :</h3>
Create an Image from the Dockerfile having Kubectl configuration file in it, which can be used as a template for creating dynamic slave node.
<br>
KUBECTL Configuration:<br>

 ![1](https://raw.githubusercontent.com/yashbajpai98/task4LW/master/task4-images/1.PNG)

Dockerfile for Slave Node:<br> 
![2](https://raw.githubusercontent.com/yashbajpai98/task4LW/master/task4-images/2.PNG)

Now, build the image <b>docker build -t kubeimage .</b>

<h3>Configuring Dynamic Slave Node :</h3>

  ![3](https://raw.githubusercontent.com/yashbajpai98/task4LW/master/task4-images/3.PNG)

First allow Jenkins to communicate with Docker server, for accomplish this, we need to edit /usr/lib/systemd/system/docker.service. Add the following to the ExecStart field: <strong>-H tcp://0.0.0.0:4243</strong>
<br>
Now, restart docker services<br>
<b> systemctl deamon-reload</b>
<br>
<b> systemctl restart docker.service</b>
<br>
You can use any free port in place of 4243. Now after this we have to add the dynamic node to the Jenkins for this : <b>Go to Manage Jenkins > Manage Nodes and Clouds > Configure Clouds > Add A New Cloud > Select Docker</b>
<br>
![4](https://raw.githubusercontent.com/yashbajpai98/task4LW/master/task4-images/4.PNG)
<h4>JOB 1</h4> : Create a job in the Jenkins, that will pull the code from the Github (having the Dockerfile of webserver), which builds and uploads the image to Docker Hub registery.
<br>

 ![job1](https://raw.githubusercontent.com/yashbajpai98/task4LW/master/task4-images/job1.PNG)

<h4>JOB 2 :</h4> This job will be executed on the dynamic slave node which will be used to Create Deployment/Roll Update for Webserver on Kubernetes. This is an downstream job for kubejob1.
<br>

 ![job2](https://raw.githubusercontent.com/yashbajpai98/task4LW/master/task4-images/job2.PNG)
Here we have selected the option Restrict where this project can be run and provided the label we have used for the dynamic node: docker, So that this job will be executed on the dynamic node.

<h3>Pipeline View: </h3>
 <br> 
 ![pipeline](https://raw.githubusercontent.com/yashbajpai98/task4LW/master/task4-images/pipeline4.PNG)
