module "lambda-checkout" {
  source      = "./modules/lambdas"
  environment = var.environment
  product     = var.product
  lambda_name = "lambda-checkout"
}
