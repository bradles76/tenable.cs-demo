terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
	  version = ">= 2.7.0"
      region  = "ap-southeast-2"
	}
  }
}