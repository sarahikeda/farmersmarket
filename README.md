# FarmersMarket

Short exercise to create a checkout system for a farmer's market vendor.

## Installation
Uses Ruby 2.2.3
 Steps:
 1. Git clone project
 2. Run `bundle install`

## Prices
```
+--------------|--------------|---------+
| Product Code |     Name     |  Price  |
+--------------|--------------|---------+
|     CH1      |   Chai       |  $3.11  |
|     AP1      |   Apples     |  $6.00  |
|     CF1      |   Coffee     | $11.23  |
|     MK1      |   Milk       |  $4.75  |
+--------------|--------------|---------+
```

## Pricing Rules:
```
BOGO -- Buy-One-Get-One-Free Special on Coffee. (Unlimited)
APPL -- If you buy 3 or more bags of Apples, the price drops to $4.50.
CHMK -- Purchase a box of Chai and get milk free. (Limit 1)
The checkout system can apply any or all of these rules.
```

## Usage
A user should be able to scan individual items and calculate the total cost at any time.
Example:
```
checkout = Checkout.new('APPL')
checkout.scan('CF1')
checkout.scan('AP1')
checkout.total
```

## Testing

Tests are written in RSpec and can be run using `bundle exec rspec`. To run an individual test from the command line, run `bundle exec rspec:LINE NUMBER OF TEST`