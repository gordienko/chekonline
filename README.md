# Chekonline

Ruby module for connecting to the [online ticketing rental service](https://www.chekonline.ru) for online stores, 
vending machines and entrepreneurs who make payments on the Internet, incl. 
upon receipt of payments to the company's settlement account.

![chekonline](https://github.com/gordienko/chekonline/blob/master/logo.png)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'chekonline', github: 'gordienko/chekonline'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install chekonline
```

## Usage
How to use my plugin.

```ruby
co = Chekonline::Client.new(mode: 'production',
                             cert: "#{Rails.root}/config/chekonline/production.crt",
                             key: "#{Rails.root}/config/chekonline/production.key")
co.add_line(qty: 1000,
            price: 10000,
            pay_attribute: 4,
            tax_id: 1,
            description: "Test item 1")

co.add_line(qty: 1000,
            price: 20000,
            pay_attribute: 4,
            tax_id: 1,
            description: "Test item 2")

co.request(place: 'https://domain.com', phone_or_email: 'username@domain.com')

```

Additional Information:

- [Download Check-Online API](http://chekonline.ru/docs/cloudapi_complex.pdf)
- [Full API of working cash register RP-System 1FS](http://chekonline.ru/docs/protocol.pdf)

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
