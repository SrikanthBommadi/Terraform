module "ec2" {
    source = "../module-ec2"  # destination of the path
    sg_id = "sg-0e73e08d24d3545ce" # if you want u can take it from reference variable also or this will over ride
    instance_type = "t3.micro"   #if u want to over ride iam just toggleing it 
}