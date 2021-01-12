# Checkout<br>
We have degigned a system for a shop with products and discounts
runs a physical store which sells 3 products:
<br>
| Code | Name | Price |
| -- | -- | -- |
| VOUCHER | Voucher     | 5.00€  |
| TSHIRT  | T-shirt     | 20.00€ |
| MUG     | Coffee mug  | 7.50€  |
<br>
Various departments have suggested some discounts to improve sales:<br>
<br>
The marketing department wants a 2-for-1 special on VOUCHER items.<br>
The CFO insists that the best way to increase sales is with (tiny) discounts on bulk purchases. If you buy 3 or more TSHIRT items, the price per unit should be 19.00€.<br>
The checkout process allows for items to be scanned in any order, and calculates the total price. The interface looks like this (in ruby):<br>
<br>
That is why we create a checkout system with the two different rules and the shop assistant will select the applicable one this way:<br>
<br>
    checkout = Checkout.new(price_rules)
    checkout.scan("VOUCHER")
    checkout.scan("VOUCHER")
    checkout.scan("TSHIRT")
    price = checkout.total
<br>
<br>
Our team will add, remove, and change products and discounts, so they are configurable with a JSON file.
