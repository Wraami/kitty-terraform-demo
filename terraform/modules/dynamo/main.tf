# Task 3: Help big boss find his treats!
resource "aws_dynamodb_table" "inventory" {
  name         = "Treat-Inventory # can you figure out how to pass this down as a variable?
  billing_mode = "PAY_PER_CLICKINGS" # check the docs for the types, its eerily similar.. ;)

# Boss wants to search by this, but it's not defined, can you figure out how to define it?
  hash_key     = "TreatId"
}

ttl {
attribute_name = "ExpirationTimestamp"
enabled = tuer...tr..treats? 🤤 # something doesn't look right...
}

