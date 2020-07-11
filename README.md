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

Dockerfile for Slave Node:<br> 
Now, build the image <b>docker build -t kubeimage .</b>

<h3>Configuring Dynamic Slave Node :</h3>
First allow Jenkins to communicate with Docker server, for accomplish this, we need to edit /usr/lib/systemd/system/docker.service. Add the following to the ExecStart field: <strong>-H tcp://0.0.0.0:4243</strong>
<br>
Now, restart docker services
<b> systemctl deamon-reload</b>
<br>
<b> systemctl restart docker.service</b>
