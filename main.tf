cat <<EOF > main.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "my-demo-bucket"
  acl    = "public-read"  # 🚨 Prisma Cloud should flag this!
}
EOF
