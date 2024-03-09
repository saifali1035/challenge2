# challenge2

Use Infrastructure as code (IaC) tool of your choice (ansible/terraform/cloudformation/python etc) and cloud of your choice (AWS/Azure/GCP). Create VM auto scaling group of 1 to 3 VMs with at least 1 VM always running and should meet following elastic criteria
a) Keep adding VM when CPU utilization goes above 80%
b) Terminate the VM when CPU utilization reduces to 30%
Provide your testing method/codes/scripts along with the IaC codebase

# Answer

Total 7 files
1. provider.tf ---> Its just have the cloud provider info and the region we are going to use.

2. data.tf ---> For the sake of keeping this project simple vpc are not created but the deafult vpc provoded with aws is used.

3. auto_scaling.tf  ---> 
    3.1 A launch configuration will be needed for the autoscaling group to work , where we will specify which type of aws instance need to be deployed.
    lifecycle block in the launch configuration has create_before_destroy set to true as this forces Terraform to create a new resource before destroying the old one.
    3.2 Define a Auto Scaling Group as resource and  parameters are desired_capacity, max_size, min_size and launch_configuration where you need to supply the "name" of launch configuration just created above.
    vpc_zone_identifier should have minimum of one subnet id in which you want your auto scaling group to operate.
    3.3 aws_autoscaling_attachment is used to attach auto scaling group with load balancer
    3.4 We have two aws_autoscaling_policy defined one for increasing the number of instance by 1 and oter for decreasing it by 1  based on load.

4. loadbalance.tf ---> A network load balancer is used which accepts tarffic from port 22.

5. output.tf ---> To get id of all the vpcs in the account

6. sg.tf ---> security group for load balancer and the launch configuration of instances

7. cloudwatch.tf ---> Two alarms to trigger the two autoscaling policies based on the CPU load.



  
                  
       