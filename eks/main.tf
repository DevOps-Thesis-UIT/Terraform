module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "tuonglinh-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "productionn"
  }
}

module "EKS" {
  source = "../modules/eks"
  name = "tuonglinh_cluster"
  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
  k8s_version = "1.29"
  cluster_vpc_cidr = module.vpc.vpc_cidr_block
  cluster_subnet_ids = module.vpc.public_subnets
  service_ipv4_cidr = "192.168.0.0/16"
  eks_addons = ["vpc-cni", "kube-proxy", "coredns"]
  node_group_subnet_ids = module.vpc.private_subnets
  node_group_min_size = 2
  node_group_max_size = 4
  node_group_desired_size = 2
}